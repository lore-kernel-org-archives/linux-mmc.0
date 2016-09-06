From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device loss]
Date: Tue, 6 Sep 2016 11:42:35 +0200
Message-ID: <CAPDyKFpnCXhdoKgoG576teC=y38vbC1x=-ehC_9EWEeKr_K6BQ@mail.gmail.com>
References: <1473080344.10346.4.camel@researchut.com> <Pine.LNX.4.44L0.1609051157310.25234-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1609051157310.25234-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 5 September 2016 at 17:58, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> On Mon, 5 Sep 2016, Ritesh Raj Sarraf wrote:
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA512
>>
>> On Sun, 2016-09-04 at 15:46 -0400, Alan Stern wrote:
>> >
>> > This is not the problem I was discussing with Ulf.  The problem was why
>> > the device kept going into and out of runtime suspend every three
>> > seconds.  The kernel log above does not say whether this was happening.
>> > One way to tell is to look at a usbmon trace (like we did before).
>>
>> https://people.debian.org/~rrs/tmp/usbmon.txt.gz
>>
>> This should have the logs you asked for, running on 4.8-rc4.
>
> Confirmed, the runtime suspends and resumes are still happening.
>
> Ulf, any insights?

Alan, Ritesh,

Yes, I am starting to understand more about what goes on here.
Although I need help to test as I don't have the HW.
As you already guessed, I suspect the problem is within the runtime PM
deployment in the drivers/mmc/host/rtsx_usb_sdmmc.c.

Let me start by first give you some background to how the mmc core
deals with runtime PM.

*)
The mmc core manages most of the calls to the pm_runtime_get|put*()
and pm_runtime_mark_last_busy() for the mmc host device. The gets/puts
are done when the core is about to access the mmc host device, via the
mmc host ops driver interface. You may search for calls to the
mmc_claim|release_host() functions to find out when the gets/puts are
done.

**)
The mmc core have also deployed runtime PM for the mmc *card* device
and which has the runtime PM autosuspend feature enabled with a 3s
default timeout. One important point is that the mmc card device has
the mmc host device assigned as being its parent device. I guessing
the reason to why you are encountering strange 3s intervals of runtime
PM suspend/resume is related to this.

Now, in this case, the rtsx_usb_sdmmc driver seems to need a bit of
special runtime PM deployment, as the calls to pm_runtime_get|put*()
also controls the power to the usb device and thus also the power to
the card. I am guessing that's done via the usb device being assigned
as parent for the mmc host's platform device!?

By reviewing the code of the rtsx_usb_sdmmc driver, particularly how
it calls pm_runtime_get|put() I am guessing those calls may not be
properly deployed. Perhaps rtsx_usb_sdmmc should convert to use the
usb_autopm_put|get_interface() and friends, although I didn't want to
make that change at this point so instead I have cooked a patch that
might fixes the behaviour.

Ritesh, can you please try it out to see what happens?

---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c
b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 6c71fc9..3d6fe51 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1138,11 +1138,6 @@ static void sdmmc_set_ios(struct mmc_host *mmc,
struct mmc_ios *ios)
        dev_dbg(sdmmc_dev(host), "%s\n", __func__);
        mutex_lock(&ucr->dev_mutex);

-       if (rtsx_usb_card_exclusive_check(ucr, RTSX_USB_SD_CARD)) {
-               mutex_unlock(&ucr->dev_mutex);
-               return;
-       }
