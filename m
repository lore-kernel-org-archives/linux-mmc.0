Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A34C10F25
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 11:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192952073B
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 11:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCFLII (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:08:08 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:41637 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFLII (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Mar 2020 06:08:08 -0500
Received: from [192.168.178.45] ([109.104.54.216]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MQMqN-1ixKu61auv-00MMb3; Fri, 06 Mar 2020 12:07:43 +0100
Subject: Re: [PATCH 10/10] ARM: dts: bcm2711: Add vmmc regulator in emmc2
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     ulf.hansson@linaro.org, f.fainelli@gmail.com, phil@raspberrypi.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org
References: <20200306103857.23962-1-nsaenzjulienne@suse.de>
 <20200306103857.23962-11-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <408aa93f-b5c8-c4b3-384b-c8d018a8d549@i2se.com>
Date:   Fri, 6 Mar 2020 12:07:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200306103857.23962-11-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:YpscJjEb7mEkNDKWeYl5eBxFpbUACDSdSpaQQlnEqPk/ccGHsqI
 nz6WoYoxp+BtaxCRE6+qukgnfB+J/MQ4ap9KGS7bQIK1WfSIV4fHemVyB3Zqx4d+hY3uw1X
 bqQjVE+lfiMgDeYcwuhLfd0PoPn9EaqU3a2FU5S507VEkXXJwPLRIXBlmwRUSg/tNioj/Xq
 J75TNMkB6cOdAfhkLaGQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W9bOt0k6oe4=:ne+o+JZ25tk0J+jrXsL/h4
 74klhx+ipS6ma+Jin4APOnQXtmvyABceMb75AWKtJwer2mgt4v+of3fY+mVDcnq3ITJzKjGvn
 tbLt2a/wxsBYrUTCapDUPrVLtK2IgxPUTSaB1R3gfg1QcbIb2y34WegsqL1BnAX+kg34rZqgr
 nTrRe28K55aM89qYhulTTXDYgInJH2sryHZl0HERhBJSEDdW8Ofb4v+nrNSXX17/8IqOtZ95f
 cUVWJwZYEIQexphhlY2I/QCKKmEDgxvBShl5rk+xu16wFrvLqBgaOBO8y7yKYMyVWl5q2RDQp
 SU4H4PV5aeWSn48fNBKUrJu5BYBSgUstdTqarigkfq2oA6hIMAmqY7KVusUe1qXuZ0Epivckf
 7zBBM+D4f7f+zeLkD/82YYi9pVEB9r+iKDs1JapeLj6ih5LrEJtSFTRndeT6kFInkw4/tdosi
 p3KSCDb780NathvMMCZ3m39C39unbSwTcrcHJ5Rpvu1h83MhDfkdw9U6k+STheNCu1CzZm4QR
 eNMWHsNNu5U4mV0loRG1nOV/gBRCB0aUGhxgq33NTy8EhODbsPYT11ZxDoxnxEOFwT1PyfecG
 75PVFHl++zj4RcdwAEh9gxp4puehkvgOV5eiIU2GRsDoeXFFB2itKWIJchsNFvwsq7X++Fxcq
 /TRx22b+1QhCm+1OuMEC2SViD44GjFOpuh2HiIjvDqZCj1S8NWd/zeRjIPkjcDwQF8ed87B80
 PLpJjQcYCxqLqpWZYWFFYFdaevCpDKN3i06gpwg29i8aF87I411975mEYgt12g6XKwXDyeTKw
 G4RZJJw7nQPtmZpdJYvyRjYpxPGUZalrJqqnngJ2NOVBhCCJ3Mi8t4sPWPfILz+CdiEWhqx3i
 amnvsTM6LrC3WAvto4K48spvxVappyZXysxe+ZRKFoL7KVBQYf7Z2EV39+pFGflG1ojsAsVI6
 kcJyk9d+6Ww==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Nicolas,

On 06.03.20 11:38, Nicolas Saenz Julienne wrote:
> The SD card power can be controlled trough a pin routed into the board's
> external GPIO expander. Turn that into a regulator and provide it to
> emmc2.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> index e26ea9006378..8e98e917f9f4 100644
> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> @@ -56,6 +56,16 @@ sd_io_1v8_reg: sd_io_1v8_reg {
>  			  3300000 0x0>;
>  		status = "okay";
>  	};
> +
> +	sd_vcc_reg: sd_vcc_reg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpio = <&expgpio 6 GPIO_ACTIVE_HIGH>;
this new GPIO has an empty GPIO label, please add it.
> +	};
>  };
>  
>  &firmware {
> @@ -174,6 +184,7 @@ brcmf: wifi@1 {
>  /* EMMC2 is used to drive the SD card */
>  &emmc2 {
>  	vqmmc-supply = <&sd_io_1v8_reg>;
> +	vmmc-supply = <&sd_vcc_reg>;
>  	broken-cd;
>  	status = "okay";
>  };
