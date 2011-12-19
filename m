From: Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH 4/15] vub300: fix module parameter.
Date: Mon, 19 Dec 2011 13:08:40 +0000
Message-ID: <1324300120.4283.6.camel@study-2>
References: <871us6tu0d.fsf@rustcorp.com.au>
	 <1324062122.2302.5.camel@study-2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62255 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab1LSNIx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2011 08:08:53 -0500
In-Reply-To: <1324062122.2302.5.camel@study-2>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org

On Thu, 2011-12-15 at 13:34 +1030, Rusty Russell wrote:
> You didn't mean this to be a bool.
> 
> Cc: Tony Olech <tony.olech@elandigitalsystems.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/mmc/host/vub300.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -259,7 +259,7 @@ static int firmware_rom_wait_states = 0x
>  static int firmware_rom_wait_states = 0x1C;
>  #endif
>  
> -module_param(firmware_rom_wait_states, bool, 0644);
> +module_param(firmware_rom_wait_states, int, 0644);
>  MODULE_PARM_DESC(firmware_rom_wait_states,
>  		 "ROM wait states byte=RRRIIEEE (Reserved Internal External)");
>  
> --
You are right.
I don't know how that slipped through
Acked-by: Tony Olech <tony.olech@elandigitalsystems.com>
Acked-by: Tony Olech <tony@olech.com>


