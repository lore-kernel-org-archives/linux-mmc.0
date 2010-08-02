From: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 03/20] mmc: support embedded data field in mmc_host
Date: Mon, 2 Aug 2010 18:25:23 +0200
Message-ID: <AANLkTikfRja-h9mz7uyRXCZNZjKdU_yB8e58XQucUzrn@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-4-git-send-email-ohad@wizery.com>
	<AANLkTimzA_JJ-byTDWznbL3YzeJ8LAP4M50onf2_3fBF@mail.gmail.com>
	<AANLkTi=Oy8X1xMOwWL_cKBB1LWULT6=p+adUgB+AuSJS@mail.gmail.com>
	<AANLkTi=BUX59heXAW2Uf4wZo2dSS19Je54dkQ5u2YGAW@mail.gmail.com>
	<AANLkTimZQKj7H_GeE=+O9cwxEMTR+LhfFbt=AyXGzN3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimZQKj7H_GeE=+O9cwxEMTR+LhfFbt=AyXGzN3d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Pandita Vikram <vikram.pandita-l0cyMroinI0@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Ohad,

On Mon, Aug 2, 2010 at 5:54 PM, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> wrote:

> SPI is using these spi_board_info tables to populate the SPI device
> trees. These tables are registered early at the board-specific init
> code, and are later used by SPI core to populate the devices when the
> SPI master controller is registered.
>
> SDIO doesn't normally needs any kind of hard coded data: most devices
> are dynamically probed and populated.
>
> On rare cases like the wl1271, we have some platform-specific data we
> need to deliver the SDIO function driver (i.e. the irq info in this
> case). Since the device is hardwired to a specific controller, it does
> make some sense to pass this private data from the controller's info
> in the board files, through the host driver, and make it accessible
> through the specific host instance that drives this controller.
>
> Btw, if our problem was be broader (e.g., needs to supply private data
> for non-hardwired devices), then I agree that a more complex
> mechanism, such as the one you suggest, would be needed. But currently
> the problem is very simple and the solution is even simpler: just add
> 1 private pointer to the host.
>
> Hope you find this reasonable,

no, actually I don't. I think this is a hack that intrudes into the
area it completely doesn't belong to.

In fact, one can have 2 views on this problem: either this is a fairly
generic problem we need to address, or this is a very specific corner
case.
Your solution will be treated as a hack in both cases.

If we consider it a generic problem, then we need to find a generic
solution, which is the board_info solution, for instance. FWIW, I2C
also uses this approach now.

If we consider it to be a corner case, let's just add a dummy
platform_device like it's done in WL1251 implementation and keep the
MMC subsystem clean.

Thanks,
   Vitaly
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
