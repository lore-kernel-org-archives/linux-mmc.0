From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/3] arm: dts: socfpga: Add support for SD/MMC
Date: Mon, 16 Sep 2013 10:36:19 -0600
Message-ID: <52373383.7030601@wwwdotorg.org>
References: <1378740833-4883-1-git-send-email-dinguyen@altera.com> <1378740833-4883-4-git-send-email-dinguyen@altera.com> <522E398F.3080100@wwwdotorg.org> <1963011.uUY4o6LRbA@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1963011.uUY4o6LRbA@flatron>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 09/14/2013 06:30 AM, Tomasz Figa wrote:
...
> Just as a side note, correct name is Synopsys, not Synopsis. There are
> multiple places around Documentation/devicetree where this typo is
> present[1]. Should we consider correcting this or the typo will have
> to stay?
> 
> [1] git grep -i synopsis Documentation/devicetree/
> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:* Samsung Exynos specific extensions to the Synopsis Designware Mobile
> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:The Synopsis designware mobile storage host controller is used to interface
> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:differences between the core Synopsis dw mshc controller properties described
> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:by synopsis-dw-mshc.txt and the properties used by the Samsung Exynos specific
> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:extensions to the Synopsis Designware Mobile Storage Host Controller.
> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:* Rockchip specific extensions to the Synopsis Designware Mobile
> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:The Synopsis designware mobile storage host controller is used to interface
> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:differences between the core Synopsis dw mshc controller properties described
> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:by synopsis-dw-mshc.txt and the properties used by the Rockchip specific
> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:extensions to the Synopsis Designware Mobile Storage Host Controller.
> Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt:* Synopsis Designware Mobile Storage Host Controller
> Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt:The Synopsis designware mobile storage host controller is used to interface
> Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt:properties used by the Synopsis Designware Mobile Storage Host Controller.
> Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt:     - snps,dw-mshc: for controllers compliant with synopsis dw-mshc.
> Documentation/devicetree/bindings/pci/designware-pcie.txt:* Synopsis Designware PCIe interface

Those typos only appear to exist in free-form text and not in any
property names/values. As such, they can all easily be fixed without
impacting any DT content or ABI.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
