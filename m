From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 5/6] arm64: dts: r8a7795: salvator: enable on-board
 eMMC
Date: Mon, 19 Sep 2016 20:25:39 +0300
Message-ID: <3abe65a3-0047-f39d-2639-b39b98081c42@cogentembedded.com>
References: <20160919124921.8172-1-wsa+renesas@sang-engineering.com>
 <20160919124921.8172-6-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:32814 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932303AbcISRZo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2016 13:25:44 -0400
Received: by mail-lf0-f48.google.com with SMTP id h127so120069313lfh.0
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2016 10:25:43 -0700 (PDT)
In-Reply-To: <20160919124921.8172-6-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>

On 09/19/2016 03:49 PM, Wolfram Sang wrote:

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> index 8964b1ea3cea69..7780d02f716a34 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
[...]
> @@ -246,6 +264,18 @@
>  		power-source = <1800>;
>  	};
>
> +	sdhi2_pins: sd2 {
> +		groups = "sdhi2_data8", "sdhi2_ctrl";
> +		function = "sdhi2";
> +		power-source = <3300>;
> +	};
> +
> +	sdhi2_pins_uhs: sd2 {
> +		groups = "sdhi2_data8", "sdhi2_ctrl";
> +		function = "sdhi2";
> +		power-source = <1800>;
> +	};
> +

    I'm afraid you're just overriding the props in the first "sd2" node with 
this...

[...]

MBR, Sergei

