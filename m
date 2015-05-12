From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH RESEND v6 1/2] arm64: dts: Add the arasan sdhci nodes in apm-storm.dtsi
Date: Tue, 12 May 2015 11:03:46 +0530
Message-ID: <CAOHikRAeOH5Pt4WZFk1C29dUytO7H0ox_dgq578oW19ue8Eb8Q@mail.gmail.com>
References: <1431333531-30491-1-git-send-email-stripathi@apm.com>
	<1431333531-30491-2-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og102.obsmtp.com ([64.18.0.143]:34688 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752464AbbELFds (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 May 2015 01:33:48 -0400
Received: by wief7 with SMTP id f7so102535951wie.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2015 22:33:46 -0700 (PDT)
In-Reply-To: <1431333531-30491-2-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, patches <patches@apm.com>, Suman Tripathi <stripathi@apm.com>

Hi ,

On Mon, May 11, 2015 at 2:08 PM, Suman Tripathi <stripathi@apm.com> wrote:
> This patch adds the arasan sdhci nodes to reuse the of-arasan
> driver for APM X-Gene SoC.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
>  arch/arm64/boot/dts/apm/apm-storm.dtsi  | 43 +++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
> index 83578e7..7ccd517 100644
> --- a/arch/arm64/boot/dts/apm/apm-mustang.dts
> +++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
> @@ -52,3 +52,7 @@
>  &xgenet {
>         status = "ok";
>  };
> +
> +&sdhci0 {
> +       status = "ok";
> +};
> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> index c8d3e0e..b5d2698 100644
> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> @@ -145,6 +145,40 @@
>                                 clock-output-names = "socplldiv2";
>                         };
>
> +                       ahbclk: ahbclk@1f2ac000 {
> +                               compatible = "apm,xgene-device-clock";
> +                               #clock-cells = <1>;
> +                               clocks = <&socplldiv2 0>;
> +                               reg = <0x0 0x1f2ac000 0x0 0x1000
> +                                       0x0 0x17000000 0x0 0x2000>;
> +                               reg-names = "csr-reg", "div-reg";
> +                               csr-offset = <0x0>;
> +                               csr-mask = <0x1>;
> +                               enable-offset = <0x8>;
> +                               enable-mask = <0x1>;
> +                               divider-offset = <0x164>;
> +                               divider-width = <0x5>;
> +                               divider-shift = <0x0>;
> +                               clock-output-names = "ahbclk";
> +                       };
> +
> +                       sdioclk: sdioclk@1f2ac000 {
> +                               compatible = "apm,xgene-device-clock";
> +                               #clock-cells = <1>;
> +                               clocks = <&socplldiv2 0>;
> +                               reg = <0x0 0x1f2ac000 0x0 0x1000
> +                                       0x0 0x17000000 0x0 0x2000>;
> +                               reg-names = "csr-reg", "div-reg";
> +                               csr-offset = <0x0>;
> +                               csr-mask = <0x2>;
> +                               enable-offset = <0x8>;
> +                               enable-mask = <0x2>;
> +                               divider-offset = <0x178>;
> +                               divider-width = <0x8>;
> +                               divider-shift = <0x0>;
> +                               clock-output-names = "sdioclk";
> +                       };
> +
>                         qmlclk: qmlclk {
>                                 compatible = "apm,xgene-device-clock";
>                                 #clock-cells = <1>;
> @@ -533,6 +567,15 @@
>                         interrupts = <0x0 0x4f 0x4>;
>                 };
>
> +               sdhci0: sdhci@1c000000 {
> +                       compatible = "arasan,sdhci-4.9a";
> +                       reg = <0x0 0x1c000000 0x0 0x100>;
> +                       interrupts = <0x0 0x49 0x4>;
> +                       dma-coherent;
> +                       clock-names = "clk_xin", "clk_ahb";
> +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
> +               };
> +
>                 phy1: phy@1f21a000 {
>                         compatible = "apm,xgene-phy";
>                         reg = <0x0 0x1f21a000 0x0 0x100>;
> --
> 1.8.2.1
>

Can anyone from dt community review this patch ? I have changed the dts node
names from sdhc to sdhci as per Arnd, Michael comments .

-- 
Thanks,
with regards,
Suman Tripathi
