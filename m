From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/2] arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.
Date: Tue, 27 Jan 2015 21:13:51 +0100
Message-ID: <4747424.udeKOcy6tC@wuerfel>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com> <1422379260-10139-3-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:50104 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbbA0UOB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jan 2015 15:14:01 -0500
In-Reply-To: <1422379260-10139-3-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: chris@printf.net, anton@enomsg.org, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com

On Tuesday 27 January 2015 22:51:00 Suman Tripathi wrote:
> 
> +               sdhc0: sdhc@1c000000 {
> +                       device_type = "sdhc";
> +                       compatible = "arasan,sdhci-8.9a";
> +                       reg = <0x0 0x1c000000 0x0 0x100>;
> +                       interrupts = <0x0 0x49 0x4>;
> +                       clock-names = "clk_xin", "clk_ahb";
> +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
> +               };
> +

Here you don't provide an 'iommus' property, which means that the
device is unable to use the iommu.

	Arnd
