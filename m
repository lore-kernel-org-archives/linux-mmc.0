From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 00/11] SDIO Runtime PM Support
Date: Thu, 7 Oct 2010 19:01:07 +0100
Message-ID: <20101007180107.GA15745@void.printf.net>
References: <1286020455-28946-1-git-send-email-ohad@wizery.com> <1286454736.27371.37.camel@chilepepper>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1286454736.27371.37.camel@chilepepper>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: ext Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Luciano, Ohad,

On Thu, Oct 07, 2010 at 03:32:16PM +0300, Luciano Coelho wrote:
> I have tested this on my beagle board with the wl1271 patches that Ohad
> provided and it seems to be working fine.  I've also created a small
> script to stress test the implementation a little bit and didn't see any
> problems.
> 
> Tested-by: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> 
> This is quite an important fix in the wl1271 point-of-view.  Chris, do
> you think there is any chance that this could make it to 2.6.37?

Yes, can do -- the patchset looks good, and I've just pushed patches
1-9 (the MMC patches) to mmc-next.  Please go ahead and submit the
two wl1271 patches through wireless-testing whenever you're ready.

Thanks!

-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
