import { useHud } from "../../context/HudContext";
import { NAV_ITEMS } from "./navItems";

export default function Navigation() {
    const { activeHud } = useHud();
    const ActiveHudComponent = activeHud.Component;

    return <ActiveHudComponent items={NAV_ITEMS} />;
}
