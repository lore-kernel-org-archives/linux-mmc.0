From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/2] ARM: dts: sun5i: Add broken-hpi property for Utoo-P66
 eMMC
Date: Tue, 31 Mar 2015 17:47:50 +0300
Message-ID: <551AB396.3040404@cogentembedded.com>
References: <1427652575-12642-1-git-send-email-hdegoede@redhat.com> <1427652575-12642-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:32942 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbbCaOry (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Mar 2015 10:47:54 -0400
Received: by lajy8 with SMTP id y8so14510755laj.0
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2015 07:47:52 -0700 (PDT)
In-Reply-To: <1427652575-12642-2-git-send-email-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org, linux-sunxi@googlegroups.com, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hello.

On 3/29/2015 9:09 PM, Hans de Goede wrote:

> The eMMC on the A13 based Utoo-P66 tablet does not properly support hpi,
> and trying to enable it results in the eMMC not working, so add a child-node
> describing the eMMC, and set the broken-hpi property on it.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   arch/arm/boot/dts/sun5i-a13-utoo-p66.dts | 6 ++++++
>   1 file changed, 6 insertions(+)

> diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
> index 6c9f5f3..5b572fa 100644
> --- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
> +++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
> @@ -150,6 +150,12 @@
>   	bus-width = <8>;
>   	non-removable;
>   	status = "okay";
> +
> +	mmmcard: mmccard@0 {

    Not "mmcard:"? :-)

[...]

WBR, Sergei

