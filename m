From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 7/8] sdio: enable Runtime PM for SDIO functions
Date: Tue, 14 Sep 2010 20:27:38 +0100
Message-ID: <20100914192738.GB21918@void.printf.net>
References: <1283858949-11073-1-git-send-email-ohad@wizery.com> <1283858949-11073-8-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1283858949-11073-8-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Gao Yunpeng <yunpeng.gao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ohad,

On Tue, Sep 07, 2010 at 02:29:08PM +0300, Ohad Ben-Cohen wrote:
> @@ -152,6 +173,11 @@ static int sdio_bus_remove(struct device *dev)
>  		sdio_release_host(func);
>  	}
>  
> +	pm_runtime_put_noidle(dev);
> +
> +	/* Undo the runtime PM settings in sdio_bus_probe() */
> +	pm_runtime_put_noidle(dev);
> +
>  	return 0;
>  }
>  

Nit:  This makes sense in context, but stands out as a possible paste
accident on first sight.  :)  I think it's worth adding a comment to
the first call; something like: 

> +     /* First, undo the increment made directly above */
> +     pm_runtime_put_noidle(dev);
> +     
> +     /* Then undo the runtime PM settings in sdio_bus_probe() */
> +     pm_runtime_put_noidle(dev);
> +     

Thanks,

-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
