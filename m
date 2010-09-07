From: David Vrabel <david.vrabel-kQvG35nSl+M@public.gmane.org>
Subject: Re: [PATCH v1 8/8] wireless: wl1271_sdio: enable Runtime PM
Date: Tue, 07 Sep 2010 14:02:10 +0100
Message-ID: <4C8637D2.5070703@csr.com>
References: <1283858949-11073-1-git-send-email-ohad@wizery.com> <1283858949-11073-9-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283858949-11073-9-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Gao Yunpeng <yunpeng.gao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Ohad Ben-Cohen wrote:
> Enable runtime pm for the wl1271 SDIO device.
> 
> We request power whenever the WLAN interface is brought up,
> and release it after the WLAN interface is taken down.
> 
> As a result, power is released immediately after probe returns,
> since at that point power has not been explicitly requested yet
> (i.e. the WLAN interface is still down).
[...]
> @@ -233,6 +241,8 @@ static int __devinit wl1271_probe(struct sdio_func *func,
>  
>  	sdio_set_drvdata(func, wl);
>  
> +	pm_runtime_put_noidle(&func->dev);

I find this a little odd and confusing as this is releasing the
reference taken by mmc core from inside the function driver.

Instead, I would suggest changing all existing SDIO function drivers to
call pm_runtime_get() in probe() and pm_runtime_put() in remove().  I
think this makes the runtime PM usage more obvious from a function
driver point of view.

> +
>  	wl1271_notice("initialized");
>  
>  	return 0;
> @@ -255,6 +265,8 @@ static void __devexit wl1271_remove(struct sdio_func *func)
>  
>  	wl1271_unregister_hw(wl);
>  	wl1271_free_hw(wl);
> +
> +	pm_runtime_get_noresume(&func->dev);
>  }
>  
>  static struct sdio_driver wl1271_sdio_driver = {

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
