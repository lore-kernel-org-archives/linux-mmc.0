From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 00/13] mmc: bcm2835: more cleanups
Date: Fri, 27 Jan 2017 09:52:37 -0800
Message-ID: <87o9ysjspm.fsf@eliezer.anholt.net>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
 <CAPDyKFoOShjQC8MbaxEuPG9m5FiSEfEd55qph3UDRHXH7C6VWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8549449249136899396=="
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFoOShjQC8MbaxEuPG9m5FiSEfEd55qph3UDRHXH7C6VWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--===============8549449249136899396==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> On 27 January 2017 at 00:37, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>   Hi folks,
>>
>> Continuing bcm283x mmc driver cleanup.  Changes:
>>
>>  * switch to threaded irq handler.
>>  * handle timeouts using delayed work instead of timers.
>>
>> With these changes most of the driver code runs in
>> thread context, which in turn allows to remove the
>> work queue and the tasklet.  Also some wait loops can
>> be simplified because almost all driver code is allowed
>> to sleep now.
>>
>> Code is also available here:
>>   git://git.kraxel.org/linux bcm2837-sdhost-cleanup
>>
>> Baseline for the patch series is this:
>>   git://git.kraxel.org/linux bcm2837-wifi
>>
>> Tested on raspberry pi 2b only so far.
>> PIO mode only, didn't try to enable DMA.
>>
>> Lots of baby patches for now, to make review
>> and (if needed) bisecting easier.  Will all be
>> squashed into the bcm283x mmc driver patch later.
>>
>> cheers,
>>   Gerd
>>
>> Gerd Hoffmann (13):
>>   mmc: bcm2835: add bcm2835_read_wait_sdcmd
>>   mmc: bcm2835: use bcm2835_read_wait_sdcmd in bcm2835_send_command
>>   mmc: bcm2835: add bcm2835_threaded_irq
>>   mmc: bcm2835: add bcm2835_check_data_error
>>   mmc: bcm2835: call bcm2835_block_irq from irqthread
>>   mmc: bcm2835: add bcm2835_check_cmd_error
>>   mmc: bcm2835: call bcm2835_busy_irq from irqthread
>>   mmc: bcm2835: split bcm2835_data_irq
>>   mmc: bcm2835: switch locking to mutex
>>   mmc: bcm2835: work queue is dead code now, zap
>>   mmc: bcm2835: kill tasklet
>>   mmc: bcm2835: move timeout to thread context
>>   mmc: bcm2835: use bcm2835_read_wait_sdcmd in bcm2835_finish_command
>>
>>  drivers/mmc/host/bcm2835.c | 448 ++++++++++++++++++++-------------------------
>>  1 file changed, 197 insertions(+), 251 deletions(-)
>>
>> --
>> 1.8.3.1
>>
>
> So, I think these kind of incremental changes on top of an old posted
> series are just confusing. Please just create a new version of the
> original series - and add a nice history of what changes have been
> made for each step.
>
> Moreover, I know I have asked before why sdhci-iproc can be extended
> for this controller. However, from the responses to some of the
> changes in this series it sounds like the controllers are related? Or
> are the controllers completely independent designed HW? Please clarify
> this once more.

There are two completely separate, unrelated controllers.  We also have
two devices we need to drive.  Thus we need to pinmux one controller to
one device, and the other controller to the other device.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAliLiOUACgkQtdYpNtH8
nugYCxAArvoQFieLA8gG2/P4meuCM2THC+y4d04sR1Y3xwM9MjYmwoEExNEZz6uB
ujKbYNDow4prKrd0yEnanATxINbsDAd2M9Vh4ge7J/BeRadYZ31LufEVVfXbb7gR
fNr2HD2Tu2WYBaMv/vDAQxnblF5kPmf6pWE8BvPps3WFvpXuHZ5UYSUXy5qBAv2d
60iA/nWbvdiSseoGPdgCyXi82iz0stmHdwiwMfE9lrdkl+kmgdaNpFz2Xq589/nQ
VwkqYJM1n1kDFGmHK5eyF5mmEwVT3l98Xzd0WvNgkUCskb/mMyMGVIFmuMvxc9Pj
6y2MVQ0IBsY6A/ax3G1ndzo7CixXEHFlH+ac7Ex/Y1OwPYKtogl/j/dbBMtGKQ9p
c5ylwj6KmV3nfGy97/R3cwDe+mxL803zufT1RfZEqYnxLq12sE/I9lGR3FXYG70E
1KwKCxndlNJ4k8QMVKIA8HDokCEOwKZXZCge0gI3u2PxxffeMqdqO7XDwbD25LGk
SfsOyEtZ6cucpbfiszty+LYTH+YpdI30mFdpgvL610DoAu/6EZ1a57YliFPXvok5
ylFgzUhb8hv43okPcuGf+H04l0K2Fl7jSKcXwSjma3zLtx7hsw3erckQvFYeVLVY
o1zBloPsKd9bHvBnnJi+c9ckj8ryVgsfUxprdFUK39oqlaKPET0=
=BKXF
-----END PGP SIGNATURE-----
--=-=-=--


--===============8549449249136899396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============8549449249136899396==--
