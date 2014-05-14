From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] drivers/mmc/host/mmc_spi.c: Use get/put_unaligned_be32
Date: Wed, 14 May 2014 14:30:45 +0200
Message-ID: <CAPDyKFqu4ZcJVZH+9-9ett1fAo5T8ff+F+hf-j95cJuRPzGi5A@mail.gmail.com>
References: <CAPDyKFo9xZ-z6eM0zG2A+=Bwj0EVyGxm=m28Lh9cHPSB+8qq1w@mail.gmail.com>
	<20140514122357.11052.qmail@ns.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140514122357.11052.qmail-HzZAx2gCgqrSUeElwK9/Pw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org>
Cc: arik-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, david.gnedt-rFfgOQFw6VLk7+2FdBfRIA@public.gmane.org, eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Linville <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, luca-XPOmlcxoEMv1KXRcyAk9cg@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 14 May 2014 14:23, George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org> wrote:
> Ulf Hansson wrote:
>> Feel free to take this through the wireless tree as well. I assumes
>> it's that same patchset as the other spi related fixes?
>
> I'd like to answer, but I'm not sure which "other spi related fixes"
> you're referring to.  If you mean patches 1 and 3 of this series, then
> obviously.  If you mean something else then probably not.
>
> [PATCH 1/3] lib/crc7: Shift crc7() output left 1 bit
> [PATCH 3/3] drivers/net/wireless/ti/wl*/spi.c: Simplify CRC computation
>

Sorry for being unclear. It's those above I referred to.

Kind regards
Ulf Hansson
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
