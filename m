From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH 2/3] drivers/mmc/host/mmc_spi.c: Use
 get/put_unaligned_be32
Date: Sun, 11 May 2014 12:33:27 +0200
Message-ID: <20140511103327.GB32609@xo-6d-61-c0.localdomain>
References: <20140511100211.1334.qmail@ns.horizon.com>
 <20140511100502.1491.qmail@ns.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140511100502.1491.qmail-HzZAx2gCgqrSUeElwK9/Pw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org>
Cc: arik-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, david.gnedt-rFfgOQFw6VLk7+2FdBfRIA@public.gmane.org, eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org, luca-XPOmlcxoEMv1KXRcyAk9cg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Sun 2014-05-11 06:05:02, George Spelvin wrote:
> Very minor source and binary size reduction.
> 
> Signed-off-by: George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org>

Reviewed-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
