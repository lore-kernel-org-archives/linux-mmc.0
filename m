From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/3] firmware: dmi_scan: Add dmi_product_name kernel
 cmdline option
Date: Fri, 3 Mar 2017 10:24:12 +0100
Message-ID: <20170303102412.52d4b692@endymion>
References: <20170225172357.26294-1-hdegoede@redhat.com>
        <20170225172357.26294-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52883 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbdCCJYQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Mar 2017 04:24:16 -0500
In-Reply-To: <20170225172357.26294-2-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jean Delvare <jdelvare@suse.com>, Takashi Iwai <tiwai@suse.de>, russianneuromancer@ya.ru, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Hans,

On Sat, 25 Feb 2017 18:23:55 +0100, Hans de Goede wrote:
> Unfortunately some firmware has all the DMI strings filled with:
> "Default String" (or something equally useless). This makes it impossible
> to apply DMI based quirks to certain machines.

Sad but true :-(

> This commit adds a dmi_product_name kernel cmdline option which can
> be used to override the DMI_PRODUCT_NAME string, so that DMI based
> quirks can still be used on such boards, there are 3 reasons for this:
> 
> 1) Rather then add cmdline options for all things which can be DMI quirked
> and thus may need to be specified, this only requires adding code for
> a single extra cmdline option

This cuts both ways. It also means that, if you get a new machine which
needs some of the quirks needed by an older machine, but not all of
them, you can't get it to work without modifying your kernel first. If
quirk options are addressed directly to the relevant subsystem, then
there is a chance that they can be reused directly for other machines
later.

> 2) Some devices can be quite quirky, e.g. the GPD win mini laptop /
> clamshell x86 machine, needing several quirks in both kernel and userspace
> (udev hwdb) in this case being able to fake a unique dmi product name
> allows making these devices usable with a single kernel cmdline option
> rather then requiring multiple kernel cmdline options + manual userspace
> tweaking
>
> 3) In some case we may be able to successfully get the manufacturer to
> fix the DMI strings with a firmware update, but not all users may want
> to update, this will allow users to use DMI based quirks without forcing
> them to update their firmware

But that's the only right thing to do. The easier we make it for
manufacturers shipping crappy BIOSes, the lesser motivated they will be
to fix them. Writing a decent DMI table is a one hour job, there's no
excuse for not doing it. So I am very reluctant to accept this patch,
sorry.

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note the GPD win: http://www.gpd.hk/gpdwin.asp is the main reason I wrote
> this patch. I've requested the manufacturer to do a BIOS update fixing the
> DMI strings, but I cannot guarantee that that will happen.
> ---
>  drivers/firmware/dmi_scan.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 54be60e..c99e753 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -1047,3 +1047,17 @@ void dmi_memdev_name(u16 handle, const char **bank, const char **device)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(dmi_memdev_name);
> +
> +static int __init dmi_parse_dmi_product_name(char *str)
> +{
> +	static char prod_name[32];
> +
> +	if (!str)
> +		return -EINVAL;
> +
> +	strlcpy(prod_name, str, sizeof(prod_name));
> +	dmi_ident[DMI_PRODUCT_NAME] = prod_name;
> +
> +	return 0;
> +}
> +early_param("dmi_product_name", dmi_parse_dmi_product_name);


-- 
Jean Delvare
SUSE L3 Support
