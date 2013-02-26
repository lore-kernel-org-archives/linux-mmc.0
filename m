From: Zhang Haijun-B42677 <B42677@freescale.com>
Subject: RE: Problem with "mmc: core: Do not rescan non-removable devices"
Date: Tue, 26 Feb 2013 10:47:42 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E1208C71@039-SN2MPN1-022.039d.mgd.msft.net>
References: <20121216163635.47537729@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_99E897753B6F7048BD8CCDB4661D02E1208C71039SN2MPN1022039d_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:12270
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754365Ab3BZKr4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Feb 2013 05:47:56 -0500
In-Reply-To: <20121216163635.47537729@notabene.brown>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>, Johan Rudholm <johan.rudholm@stericsson.com>, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

--_002_99E897753B6F7048BD8CCDB4661D02E1208C71039SN2MPN1022039d_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, all

Could you pls help view the log below and give some suggestion?
I see this patch disable the rescan when the card was non-removable. So non=
-removable card didn't need to detect the card. This can avoid to claim hos=
t for card detecting. But for sd card it still need to detect.
When mmc_rescan invoke mmc_claim_host to claim host for detecting card it w=
as often blocked for more than 120s because of long time read or write thre=
ad hold the host. Then the call trace represent.

In queue.c there was a thread(mmc_queue_thread) to handle the request. When=
 they first fetch a request it will hold the host(mmc_claim_host) until all=
 the request were handled. These request often need more than 120s to be co=
mplete. Then task hung appeared.

All the request can be complete with no err, just call trace will be genera=
ted. Did you ever met this issue before?

Expect your response.
Thanks in advance.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
<7>mmc0:     65536 bytes transferred: 0
<7>mmc0:     CMD12 arg 00000000 flags 0000049d
<7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000a
<7>mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
<7>mmc0: starting CMD18 arg 00829c98 flags 000000b5
<7>mmc0:     blksz 512 blocks 128 flags 00000200 tsac 100 ms nsac 0
<7>sdhci [sdhci_data_irq()]: mmc0: DMA base 0x2e520000, transferred 0x06000=
0 byt
es, next 0x2e580000
INFO: task kworker/u:0:5 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u:0     D
 00000000     0     5      2 0x00000000
Call Trace:
[ee04fd50] [44042028] 0x44042028
 (unreliable)

[ee04fe10] [c0007a0c] __switch_to+0xa0/0xf0
[ee04fe30] [c04dd514] __schedule+0x1f8/0x4a4

[ee04fea0] [c04dd8a0] schedule+0x30/0xbc
[ee04feb0] [c0381698] __mmc_claim_host+0x98/0x19c

[ee04ff00] [c0385f7c] mmc_sd_detect+0x38/0xc0
[ee04ff10] [c0382b00] mmc_rescan+0x294/0x2e0
[ee04ff40] [c00661cc] process_one_work+0x140/0x3e0

[ee04ff70] [c0066bf8] worker_thread+0x18c/0x36c
[ee04ffb0] [c006bf10] kthread+0x7c/0x80

[ee04fff0] [c000de58] kernel_thread+0x4c/0x68
<7>mmc0:     65536 bytes transferred: 0
<7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
<7>mmc0:     CMD12 arg 00000000 flags 0000049d
<7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000a
<7>mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
<7>mmc0: starting CMD18 arg 00903a00 flags 000000b5
<7>mmc0:     blksz 512 blocks 128 flags 00000200 tsac 100 ms nsac 0
<7>sdhci [sdhci_data_irq()]: mmc0: DMA base 0x2e530000, transferred 0x05000=
0 byt
es, next 0x2e580000
<7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
<7>mmc0:     65536 bytes transferred: 0
<7>mmc0:     CMD12 arg 00000000 flags 0000049d
<7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000a
<7>mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
<7>mmc0:     blksz 512 blocks 128 flags 00000200 tsac 100 ms nsac 0
<7>sdhci [sdhci_data_irq()]: mmc0: DMA base 0x2e520000, transferred 0x06000=
0 byt
es, next 0x2e580000
<7>mmc0:     65536 bytes transferred: 0
<7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
<7>mmc0:     CMD12 arg 00000000 flags 0000049d
<7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000a
INFO: task kworker/u:0:5 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u:0     D
 00000000     0     5      2 0x00000000
Call Trace:
[ee04fd50] [44042028] 0x44042028
 (unreliable)

[ee04fe10] [c0007a0c] __switch_to+0xa0/0xf0
[ee04fe30] [c04dd514] __schedule+0x1f8/0x4a4

[ee04fea0] [c04dd8a0] schedule+0x30/0xbc
[ee04feb0] [c0381698] __mmc_claim_host+0x98/0x19c

[ee04ff00] [c0385f7c] mmc_sd_detect+0x38/0xc0
[ee04ff10] [c0382b00] mmc_rescan+0x294/0x2e0

[ee04ff40] [c00661cc] process_one_work+0x140/0x3e0
[ee04ff70] [c0066bf8] worker_thread+0x18c/0x36c

[ee04ffb0] [c006bf10] kthread+0x7c/0x80
[ee04fff0] [c000de58] kernel_thread+0x4c/0x68

<7>mmc0:     CMD12 arg 00000000 flags 0000049d
<7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000a
<7>mmc0: starting CMD18 arg 00ad6a70 flags 000000b5
<7>mmc0:     blksz 512 blocks 128 flags 00000200 tsac 100 ms nsac 0
<7>sdhci [sdhci_data_irq()]: mmc0: DMA base 0x2e530000, transferred 0x05000=
0 byt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D




Regards
Haijun.

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of NeilBrown
> Sent: Sunday, December 16, 2012 1:37 PM
> To: Johan Rudholm; Chris Ball
> Cc: Ulf Hansson; Linus Walleij; linux-mmc@vger.kernel.org
> Subject: Problem with "mmc: core: Do not rescan non-removable devices"
>=20
>=20
> hi,
>  the commit below causes my wifi to disappear on suspend and never
> reappear.
>  Unfortunately the commentary says what the patch does but not why, so I
> cannot tell if simply reverting it is correct, or if something more
> subtle  in needed.
>=20
>  My wifi chip is a "libertas" driven "Marvell" chip.  It is permanently
> attached to port 1 on an OMAP3 'hsmmc' interface.  So
> MMC_CAP_NONREMOVABLE  seem appropriate and is set.
>=20
>  It is normally inactive and when the suspend code notices this it
> doesn't  bother trying to suspend through the driver but just removes the
> core:
> 			/*
> 			 * We simply "remove" the card in this case.
> 			 * It will be redetected on resume.  (Calling
> 			 * bus_ops->remove() with a claimed host can
> 			 * deadlock.)
> 			 */
>  (in mmc_suspend_host).  Only it isn't redetected on resume because
> rescan_entered is set.
>=20
>  I guess we could clear rescan_entered at this point.  Would that make
> sense?
>  It seems to work.
>=20
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> 06c42cf..65b8935 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2433,6 +2433,7 @@ int mmc_suspend_host(struct mmc_host *host)
>  			mmc_claim_host(host);
>  			mmc_detach_bus(host);
>  			mmc_power_off(host);
> +			host->rescan_entered =3D 0;
>  			mmc_release_host(host);
>  			host->pm_flags =3D 0;
>  			err =3D 0;
>=20
>=20
> Thanks,
> NeilBrown
>=20
>=20
>=20
> From 3339d1e33185798a45dbdb5ea6c0bec1c27ca5fd Mon Sep 17 00:00:00 2001
> From: Johan Rudholm <johan.rudholm@stericsson.com>
> Date: Thu, 23 Aug 2012 13:40:55 +0200
> Subject: [PATCH] mmc: core: Do not rescan non-removable devices
>=20
> If MMC_CAP_NONREMOVABLE is set, only issue a detect job on init.
>=20
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Chris Ball <cjb@laptop.org>
>=20
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> 835c9f0..af2c4d2 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2053,6 +2053,11 @@ void mmc_rescan(struct work_struct *work)
>  	if (host->rescan_disable)
>  		return;
>=20
> +	/* If there is a non-removable card registered, only scan once */
> +	if ((host->caps & MMC_CAP_NONREMOVABLE) && host->rescan_entered)
> +		return;
> +	host->rescan_entered =3D 1;
> +
>  	mmc_bus_get(host);
>=20
>  	/*
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
> f578a71..d5d9bd4 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -300,6 +300,7 @@ struct mmc_host {
>  #endif
>=20
>  	int			rescan_disable;	/* disable card detection */
> +	int			rescan_entered;	/* used with nonremovable
> devices */
>=20
>  	struct mmc_card		*card;		/* device attached to
> this host */
>=20

--_002_99E897753B6F7048BD8CCDB4661D02E1208C71039SN2MPN1022039d_
Content-Type: text/plain; name="call_trace.txt"
Content-Description: call_trace.txt
Content-Disposition: attachment; filename="call_trace.txt"; size=13263;
	creation-date="Tue, 26 Feb 2013 10:44:23 GMT";
	modification-date="Tue, 26 Feb 2013 10:46:13 GMT"
Content-Transfer-Encoding: base64

aW96b25lIC1SYWIgL3NtYnNoYXJlL3Jlc3VsdC54bHMgLWkgMCAtaSAxIC1mIC9zbWJzaGFyZS90
ZXN0ZmlsIA1lICAtbiAzLjVHIC1nIDMuNUcgLXIgNjRrDQoJSW96b25lOiBQZXJmb3JtYW5jZSBU
ZXN0IG9mIEZpbGUgSS9PDQoJICAgICAgICBWZXJzaW9uICRSZXZpc2lvbjogMy4yNjMgJA0KCQlD
b21waWxlZCBmb3IgMzIgYml0IG1vZGUuDQoJCUJ1aWxkOiBsaW51eC1wb3dlcnBjIA0KDQoJQ29u
dHJpYnV0b3JzOldpbGxpYW0gTm9yY290dCwgRG9uIENhcHBzLCBJc29tIENyYXdmb3JkLCBLaXJi
eSBDb2xsaW5zDQoJICAgICAgICAgICAgIEFsIFNsYXRlciwgU2NvdHQgUmhpbmUsIE1pa2UgV2lz
bmVyLCBLZW4gR29zcw0KCSAgICAgICAgICAgICBTdGV2ZSBMYW5kaGVyciwgQnJhZCBTbWl0aCwg
TWFyayBLZWxseSwgRHIuIEFsYWluIENZUiwNCgkgICAgICAgICAgICAgUmFuZHkgRHVubGFwLCBN
YXJrIE1vbnRhZ3VlLCBEYW4gTWlsbGlvbiwgDQoJICAgICAgICAgICAgIEplYW4tTWFyYyBadWNj
b25pLCBKZWZmIEJsb21iZXJnLA0KCSAgICAgICAgICAgICBFcmlrIEhhYmJpbmdhLCBLcmlzIFN0
cmVja2VyLCBXYWx0ZXIgV29uZy4NCg0KCVJ1biBiZWdhbjogU2F0IEZlYiAyMyAwNToxNTo1OSAy
MDEzDQoNCglFeGNlbCBjaGFydCBnZW5lcmF0aW9uIGVuYWJsZWQNCglBdXRvIE1vZGUNCglVc2lu
ZyBtaW5pbXVtIGZpbGUgc2l6ZSBvZiAzMTQ1NzI4IGtpbG9ieXRlcy4NCglVc2luZyBtYXhpbXVt
IGZpbGUgc2l6ZSBvZiAzMTQ1NzI4IGtpbG9ieXRlcy4NCglSZWNvcmQgU2l6ZSA2NCBLQg0KCUNv
bW1hbmQgbGluZSB1c2VkOiBpb3pvbmUgLVJhYiAvc21ic2hhcmUvcmVzdWx0LnhscyAtaSAwIC1p
IDEgLWYgL3NtYnNoYXJlL3Rlc3RmaWxlIC1uIDMuNUcgLWcgMy41RyAtciA2NGsNCglPdXRwdXQg
aXMgaW4gS2J5dGVzL3NlYw0KCVRpbWUgUmVzb2x1dGlvbiA9IDAuMDAwMDAxIHNlY29uZHMuDQoJ
UHJvY2Vzc29yIGNhY2hlIHNpemUgc2V0IHRvIDEwMjQgS2J5dGVzLg0KCVByb2Nlc3NvciBjYWNo
ZSBsaW5lIHNpemUgc2V0IHRvIDMyIGJ5dGVzLg0KCUZpbGUgc3RyaWRlIHNpemUgc2V0IHRvIDE3
ICogcmVjb3JkIHNpemUuDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByYW5kb20gIHJhbmRvbSAgICBia3dkICByZWNvcmQgIHN0cmlk
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgIEtCICBy
ZWNsZW4gICB3cml0ZSByZXdyaXRlICAgIHJlYWQgICAgcmVyZWFkICAgIHJlYWQgICB3cml0ZSAg
ICByZWFkIHJld3JpdGUgICAgcmVhZCAgIGZ3cml0ZSBmcmV3cml0ZSAgIGZyZWFkICBmcmVyZWFk
DQogICAgICAgICAzMTQ1NzI4ICAgICAgNjQ8Nz5tbWMwOiAgICAgKENNRDEyKTogMDogMDAwMDAw
MDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCjw3PnNkaGNpIFtzZGhjaV9kYXRhX2lycSgp
XTogbW1jMDogRE1BIGJhc2UgMHgxM2VhMDAwMCwgdHJhbnNmZXJyZWQgMHgwNjAwMDAgYnl0ZXMs
IG5leHQgMHgxM2YwMDAwMA0KPDc+bW1jMDogcmVxIGRvbmUgKENNRDI1KTogMDogMDAwMDA5MDAg
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCjw3PnNkaGNpIFtzZGhjaV9kYXRhX2lycSgpXTog
bW1jMDogRE1BIGJhc2UgMHgxMzE4MDAwMCwgdHJhbnNmZXJyZWQgMHgwODAwMDAgYnl0ZXMsIG5l
eHQgMHgxMzIwMDAwMA0KPDc+bW1jMDogICAgIChDTUQxMik6IDA6IDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwMDAwIDAwMDAwMDAwDQo8Nz5zZGhjaSBbc2RoY2lfaXJxKCldOiAqKiogbW1jMCBnb3Qg
aW50ZXJydXB0OiAweDAwMDAwMDA4DQo8Nz5tbWMwOiAgICAgYmxrc3ogNTEyIGJsb2NrcyAxMjgg
ZmxhZ3MgMDAwMDAxMDAgdHNhYyAzMjAwIG1zIG5zYWMgMTYwMDANCjw3PnNkaGNpIFtzZGhjaV9p
cnEoKV06ICoqKiBtbWMwIGdvdCBpbnRlcnJ1cHQ6IDB4MDAwMDAwMDENCjw3PnNkaGNpIFtzZGhj
aV9kYXRhX2lycSgpXTogbW1jMDogRE1BIGJhc2UgMHgxNDZjMDAwMCwgdHJhbnNmZXJyZWQgMHgw
NDAwMDAgYnl0ZXMsIG5leHQgMHgxNDcwMDAwMA0KPDc+bW1jMDogc3RhcnRpbmcgQ01EMjUgYXJn
IDAwMGY2ODU4IGZsYWdzIDAwMDAwMGI1DQo8Nz5zZGhjaSBbc2RoY2lfZGF0YV9pcnEoKV06IG1t
YzA6IERNQSBiYXNlIDB4MTE5ZTAwMDAsIHRyYW5zZmVycmVkIDB4MDIwMDAwIGJ5dGVzLCBuZXh0
IDB4MTFhMDAwMDANCjw3PnNkaGNpIFtzZGhjaV9pcnEoKV06ICoqKiBtbWMwIGdvdCBpbnRlcnJ1
cHQ6IDB4MDAwMDAwMDgNCjw3Pm1tYzA6IHN0YXJ0aW5nIENNRDI1IGFyZyAwMDBmZmVhOCBmbGFn
cyAwMDAwMDBiNQ0KPDc+bW1jMDogICAgIENNRDEyIGFyZyAwMDAwMDAwMCBmbGFncyAwMDAwMDQ5
ZA0KPDc+bW1jMDogc3RhcnRpbmcgQ01EMjUgYXJnIDAwMTI2NTAwIGZsYWdzIDAwMDAwMGI1DQo8
Nz5tbWMwOiByZXEgZG9uZSAoQ01EMjUpOiAwOiAwMDAwMDkwMCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMA0KPDc+c2RoY2kgW3NkaGNpX2lycSgpXTogKioqIG1tYzAgZ290IGludGVycnVwdDog
MHgwMDAwMDAwMQ0KPDc+bW1jMDogICAgIENNRDEyIGFyZyAwMDAwMDAwMCBmbGFncyAwMDAwMDQ5
ZA0KPDc+c2RoY2kgW3NkaGNpX2lycSgpXTogKioqIG1tYzAgZ290IGludGVycnVwdDogMHgwMDAw
MDAwOA0KPDc+bW1jMDogICAgIGJsa3N6IDUxMiBibG9ja3MgMTI4IGZsYWdzIDAwMDAwMTAwIHRz
YWMgMzIwMCBtcyBuc2FjIDE2MDAwDQo8Nz5tbWMwOiByZXEgZG9uZSAoQ01EMTMpOiAwOiAwMDAw
MDkwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KPDc+c2RoY2kgW3NkaGNpX2lycSgpXTog
KioqIG1tYzAgZ290IGludGVycnVwdDogMHgwMDAwMDAwOA0KPDc+c2RoY2kgW3NkaGNpX2lycSgp
XTogKioqIG1tYzAgZ290IGludGVycnVwdDogMHgwMDAwMDAwMg0KPDc+bW1jMDogc3RhcnRpbmcg
Q01EMTMgYXJnIDAwMDEwMDAwIGZsYWdzIDAwMDAwMTk1DQo8Nz5tbWMwOiBzdGFydGluZyBDTUQy
NSBhcmcgMDAxOTc2YTAgZmxhZ3MgMDAwMDAwYjUNCjw3PnNkaGNpIFtzZGhjaV9pcnEoKV06ICoq
KiBtbWMwIGdvdCBpbnRlcnJ1cHQ6IDB4MDAwMDAwMDENCjw3PnNkaGNpIFtzZGhjaV9pcnEoKV06
ICoqKiBtbWMwIGdvdCBpbnRlcnJ1cHQ6IDB4MDAwMDAwMDgNCjw3Pm1tYzA6IHN0YXJ0aW5nIENN
RDEzIGFyZyAwMDAxMDAwMCBmbGFncyAwMDAwMDE5NQ0KPDc+bW1jMDogICAgIChDTUQxMik6IDA6
IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwDQo8Nz5tbWMwOiAgICAgKENNRDEy
KTogMDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCjw3Pm1tYzA6ICAgICA2
NTUzNiBieXRlcyB0cmFuc2ZlcnJlZDogMA0KPDc+bW1jMDogICAgIDY1NTM2IGJ5dGVzIHRyYW5z
ZmVycmVkOiAwDQo8Nz5zZGhjaSBbc2RoY2lfaXJxKCldOiAqKiogbW1jMCBnb3QgaW50ZXJydXB0
OiAweDAwMDAwMDAxDQo8Nz5zZGhjaSBbc2RoY2lfaXJxKCldOiAqKiogbW1jMCBnb3QgaW50ZXJy
dXB0OiAweDAwMDAwMDAxDQo8Nz5zZGhjaSBbc2RoY2lfaXJxKCldOiAqKiogbW1jMCBnb3QgaW50
ZXJydXB0OiAweDAwMDAwMDA4DQo8Nz5tbWMwOiBzdGFydGluZyBDTUQyNSBhcmcgMDAyNmNhMTAg
ZmxhZ3MgMDAwMDAwYjUNCjw3PnNkaGNpIFtzZGhjaV9kYXRhX2lycSgpXTogbW1jMDogRE1BIGJh
c2UgMHgxMGNjMDAwMCwgdHJhbnNmZXJyZWQgMHgwNDAwMDAgYnl0ZXMsIG5leHQgMHgxMGQwMDAw
MA0KPDc+bW1jMDogc3RhcnRpbmcgQ01EMjUgYXJnIDAwMjc2MDUwIGZsYWdzIDAwMDAwMGI1DQo8
Nz5tbWMwOiByZXEgZG9uZSAoQ01EMTMpOiAwOiAwMDAwMDkwMCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMA0KPDc+bW1jMDogICAgIDY1NTM2IGJ5dGVzIHRyYW5zZmVycmVkOiAwDQo8Nz5zZGhj
aSBbc2RoY2lfaXJxKCldOiAqKiogbW1jMCBnb3QgaW50ZXJydXB0OiAweDAwMDAwMDA4DQo8Nz5z
ZGhjaSBbc2RoY2lfaXJxKCldOiAqKiogbW1jMCBnb3QgaW50ZXJydXB0OiAweDAwMDAwMDAxDQo8
Nz5zZGhjaSBbc2RoY2lfaXJxKCldOiAqKiogbW1jMCBnb3QgaW50ZXJydXB0OiAweDAwMDAwMDAx
DQo8Nz5zZGhjaSBbc2RoY2lfaXJxKCldOiAqKiogbW1jMCBnb3QgaW50ZXJydXB0OiAweDAwMDAw
MDAxDQo8Nz5tbWMwOiAgICAgQ01EMTIgYXJnIDAwMDAwMDAwIGZsYWdzIDAwMDAwNDlkDQo8Nz5t
bWMwOiAgICAgNjU1MzYgYnl0ZXMgdHJhbnNmZXJyZWQ6IDANCklORk86IHRhc2sga3dvcmtlci91
OjI6Nzg1IGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAxMjAgc2Vjb25kcy4NCiJlY2hvIDAgPiAvcHJv
Yy9zeXMva2VybmVsL2h1bmdfdGFza190aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2Fn
ZS4NCmt3b3JrZXIvdToyICAgICBEIDAwMDAwMDAwMDAwMDAwMDAgICAgIDAgICA3ODUgICAgICAy
IDB4MDAwMDAwMDANCkNhbGwgVHJhY2U6DQpbYzAwMDAwMDJmNjYwMzc5MF0gW2MwMDAwMDAwMDAw
MDk1MThdIC5MMQIzKzB4MmMvMHg0OA0KW2MwMDAwMDAyZjY2MDM4MjBdIFtjMDAwMDAwMDAwNjU1
ZTFjXSAuX19zY2hlZHVsZSsweDI4Yy8weDY1MA0KW2MwMDAwMDAyZjY2MDNhYTBdIFtjMDAwMDAw
MDAwNjU2MmQwXSAuc2NoZWR1bGUrMHgzMC8weGUwDQpbYzAwMDAwMDJmNjYwM2IyMF0gW2MwMDAw
MDAwMDA0YzA0YzBdIC5fX21tY19jbGFpbV9ob3N0KzB4ZDAvMHgyNDANCltjMDAwMDAwMmY2NjAz
YzAwXSBbYzAwMDAwMDAwMDRjNDYyY10gLm1tY19kZXRlY3QrMHgzYy8weDExMA0KW2MwMDAwMDAy
ZjY2MDNjOTBdIFtjMDAwMDAwMDAwNGMxZWVjXSAubW1jX3Jlc2NhbisweDM1Yy8weDNkMA0KW2Mw
MDAwMDAyZjY2MDNkNTBdIFtjMDAwMDAwMDAwMDY5YTUwXSAucHJvY2Vzc19vbmVfd29yaysweDE4
MC8weDQ5MA0KW2MwMDAwMDAyZjY2MDNlMTBdIFtjMDAwMDAwMDAwMDZhNzQwXSAud29ya2VyX3Ro
cmVhZCsweDFjMC8weDQ1MA0KW2MwMDAwMDAyZjY2MDNlZDBdIFtjMDAwMDAwMDAwMDcwYzk0XSAu
a3RocmVhZCsweGI0LzB4YzANCltjMDAwMDAwMmY2NjAzZjkwXSBbYzAwMDAwMDAwMDAxNTg0OF0g
Lmtlcm5lbF90aHJlYWQrMHg1NC8weDcwDQpJTkZPOiB0YXNrIGt3b3JrZXIvdToyOjc4NSBibG9j
a2VkIGZvciBtb3JlIHRoYW4gMTIwIHNlY29uZHMuDQoiZWNobyAwID4gL3Byb2Mvc3lzL2tlcm5l
bC9odW5nX3Rhc2tfdGltZW91dF9zZWNzIiBkaXNhYmxlcyB0aGlzIG1lc3NhZ2UuDQprd29ya2Vy
L3U6MiAgICAgRCAwMDAwMDAwMDAwMDAwMDAwICAgICAwICAgNzg1ICAgICAgMiAweDAwMDAwMDAw
DQpDYWxsIFRyYWNlOg0KW2MwMDAwMDAyZjY2MDM3OTBdIFtjMDAwMDAwMDAwMDA5NTE4XSAuTDEC
MysweDJjLzB4NDgNCltjMDAwMDAwMmY2NjAzODIwXSBbYzAwMDAwMDAwMDY1NWUxY10gLl9fc2No
ZWR1bGUrMHgyOGMvMHg2NTANCltjMDAwMDAwMmY2NjAzYWEwXSBbYzAwMDAwMDAwMDY1NjJkMF0g
LnNjaGVkdWxlKzB4MzAvMHhlMA0KW2MwMDAwMDAyZjY2MDNiMjBdIFtjMDAwMDAwMDAwNGMwNGMw
XSAuX19tbWNfY2xhaW1faG9zdCsweGQwLzB4MjQwDQpbYzAwMDAwMDJmNjYwM2MwMF0gW2MwMDAw
MDAwMDA0YzQ2MmNdIC5tbWNfZGV0ZWN0KzB4M2MvMHgxMTANCltjMDAwMDAwMmY2NjAzYzkwXSBb
YzAwMDAwMDAwMDRjMWVlY10gLm1tY19yZXNjYW4rMHgzNWMvMHgzZDANCltjMDAwMDAwMmY2NjAz
ZDUwXSBbYzAwMDAwMDAwMDA2OWE1MF0gLnByb2Nlc3Nfb25lX3dvcmsrMHgxODAvMHg0OTANCltj
MDAwMDAwMmY2NjAzZTEwXSBbYzAwMDAwMDAwMDA2YTc0MF0gLndvcmtlcl90aHJlYWQrMHgxYzAv
MHg0NTANCltjMDAwMDAwMmY2NjAzZWQwXSBbYzAwMDAwMDAwMDA3MGM5NF0gLmt0aHJlYWQrMHhi
NC8weGMwDQpbYzAwMDAwMDJmNjYwM2Y5MF0gW2MwMDAwMDAwMDAwMTU4NDhdIC5rZXJuZWxfdGhy
ZWFkKzB4NTQvMHg3MA0KSU5GTzogdGFzayBrd29ya2VyL3U6Mjo3ODUgYmxvY2tlZCBmb3IgbW9y
ZSB0aGFuIDEyMCBzZWNvbmRzLg0KImVjaG8gMCA+IC9wcm9jL3N5cy9rZXJuZWwvaHVuZ190YXNr
X3RpbWVvdXRfc2VjcyIgZGlzYWJsZXMgdGhpcyBtZXNzYWdlLg0Ka3dvcmtlci91OjIgICAgIEQg
MDAwMDAwMDAwMDAwMDAwMCAgICAgMCAgIDc4NSAgICAgIDIgMHgwMDAwMDAwMA0KQ2FsbCBUcmFj
ZToNCltjMDAwMDAwMmY2NjAzNzkwXSBbYzAwMDAwMDAwMDAwOTUxOF0gLkwxAjMrMHgyYy8weDQ4
DQpbYzAwMDAwMDJmNjYwMzgyMF0gW2MwMDAwMDAwMDA2NTVlMWNdIC5fX3NjaGVkdWxlKzB4Mjhj
LzB4NjUwDQpbYzAwMDAwMDJmNjYwM2FhMF0gW2MwMDAwMDAwMDA2NTYyZDBdIC5zY2hlZHVsZSsw
eDMwLzB4ZTANCltjMDAwMDAwMmY2NjAzYjIwXSBbYzAwMDAwMDAwMDRjMDRjMF0gLl9fbW1jX2Ns
YWltX2hvc3QrMHhkMC8weDI0MA0KW2MwMDAwMDAyZjY2MDNjMDBdIFtjMDAwMDAwMDAwNGM0NjJj
XSAubW1jX2RldGVjdCsweDNjLzB4MTEwDQpbYzAwMDAwMDJmNjYwM2M5MF0gW2MwMDAwMDAwMDA0
YzFlZWNdIC5tbWNfcmVzY2FuKzB4MzVjLzB4M2QwDQpbYzAwMDAwMDJmNjYwM2Q1MF0gW2MwMDAw
MDAwMDAwNjlhNTBdIC5wcm9jZXNzX29uZV93b3JrKzB4MTgwLzB4NDkwDQpbYzAwMDAwMDJmNjYw
M2UxMF0gW2MwMDAwMDAwMDAwNmE3NDBdIC53b3JrZXJfdGhyZWFkKzB4MWMwLzB4NDUwDQpbYzAw
MDAwMDJmNjYwM2VkMF0gW2MwMDAwMDAwMDAwNzBjOTRdIC5rdGhyZWFkKzB4YjQvMHhjMA0KW2Mw
MDAwMDAyZjY2MDNmOTBdIFtjMDAwMDAwMDAwMDE1ODQ4XSAua2VybmVsX3RocmVhZCsweDU0LzB4
NzANCjw3Pm1tYzA6IHN0YXJ0aW5nIENNRDEzIGFyZyAwMDAxMDAwMCBmbGFncyAwMDAwMDE5NQ0K
SU5GTzogdGFzayBrd29ya2VyL3U6Mjo3ODUgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMCBzZWNv
bmRzLg0KImVjaG8gMCA+IC9wcm9jL3N5cy9rZXJuZWwvaHVuZ190YXNrX3RpbWVvdXRfc2VjcyIg
ZGlzYWJsZXMgdGhpcyBtZXNzYWdlLg0Ka3dvcmtlci91OjIgICAgIEQgMDAwMDAwMDAwMDAwMDAw
MCAgICAgMCAgIDc4NSAgICAgIDIgMHgwMDAwMDAwMA0KQ2FsbCBUcmFjZToNCltjMDAwMDAwMmY2
NjAzNzkwXSBbYzAwMDAwMDAwMDAwOTUxOF0gLkwxAjMrMHgyYy8weDQ4DQpbYzAwMDAwMDJmNjYw
MzgyMF0gW2MwMDAwMDAwMDA2NTVlMWNdIC5fX3NjaGVkdWxlKzB4MjhjLzB4NjUwDQpbYzAwMDAw
MDJmNjYwM2FhMF0gW2MwMDAwMDAwMDA2NTYyZDBdIC5zY2hlZHVsZSsweDMwLzB4ZTANCltjMDAw
MDAwMmY2NjAzYjIwXSBbYzAwMDAwMDAwMDRjMDRjMF0gLl9fbW1jX2NsYWltX2hvc3QrMHhkMC8w
eDI0MA0KW2MwMDAwMDAyZjY2MDNjMDBdIFtjMDAwMDAwMDAwNGM0NjJjXSAubW1jX2RldGVjdCsw
eDNjLzB4MTEwDQpbYzAwMDAwMDJmNjYwM2M5MF0gW2MwMDAwMDAwMDA0YzFlZWNdIC5tbWNfcmVz
Y2FuKzB4MzVjLzB4M2QwDQpbYzAwMDAwMDJmNjYwM2Q1MF0gW2MwMDAwMDAwMDAwNjlhNTBdIC5w
cm9jZXNzX29uZV93b3JrKzB4MTgwLzB4NDkwDQpbYzAwMDAwMDJmNjYwM2UxMF0gW2MwMDAwMDAw
MDAwNmE3NDBdIC53b3JrZXJfdGhyZWFkKzB4MWMwLzB4NDUwDQpbYzAwMDAwMDJmNjYwM2VkMF0g
W2MwMDAwMDAwMDAwNzBjOTRdIC5rdGhyZWFkKzB4YjQvMHhjMA0KW2MwMDAwMDAyZjY2MDNmOTBd
IFtjMDAwMDAwMDAwMDE1ODQ4XSAua2VybmVsX3RocmVhZCsweDU0LzB4NzANCklORk86IHRhc2sg
a3dvcmtlci91OjI6Nzg1IGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAxMjAgc2Vjb25kcy4NCiJlY2hv
IDAgPiAvcHJvYy9zeXMva2VybmVsL2h1bmdfdGFza190aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRo
aXMgbWVzc2FnZS4NCmt3b3JrZXIvdToyICAgICBEIDAwMDAwMDAwMDAwMDAwMDAgICAgIDAgICA3
ODUgICAgICAyIDB4MDAwMDAwMDANCkNhbGwgVHJhY2U6DQpbYzAwMDAwMDJmNjYwMzc5MF0gW2Mw
MDAwMDAwMDAwMDk1MThdIC5MMQIzKzB4MmMvMHg0OA0KW2MwMDAwMDAyZjY2MDM4MjBdIFtjMDAw
MDAwMDAwNjU1ZTFjXSAuX19zY2hlZHVsZSsweDI4Yy8weDY1MA0KW2MwMDAwMDAyZjY2MDNhYTBd
IFtjMDAwMDAwMDAwNjU2MmQwXSAuc2NoZWR1bGUrMHgzMC8weGUwDQpbYzAwMDAwMDJmNjYwM2Iy
MF0gW2MwMDAwMDAwMDA0YzA0YzBdIC5fX21tY19jbGFpbV9ob3N0KzB4ZDAvMHgyNDANCltjMDAw
MDAwMmY2NjAzYzAwXSBbYzAwMDAwMDAwMDRjNDYyY10gLm1tY19kZXRlY3QrMHgzYy8weDExMA0K
W2MwMDAwMDAyZjY2MDNjOTBdIFtjMDAwMDAwMDAwNGMxZWVjXSAubW1jX3Jlc2NhbisweDM1Yy8w
eDNkMA0KW2MwMDAwMDAyZjY2MDNkNTBdIFtjMDAwMDAwMDAwMDY5YTUwXSAucHJvY2Vzc19vbmVf
d29yaysweDE4MC8weDQ5MA0KW2MwMDAwMDAyZjY2MDNlMTBdIFtjMDAwMDAwMDAwMDZhNzQwXSAu
d29ya2VyX3RocmVhZCsweDFjMC8weDQ1MA0KW2MwMDAwMDAyZjY2MDNlZDBdIFtjMDAwMDAwMDAw
MDcwYzk0XSAua3RocmVhZCsweGI0LzB4YzANCltjMDAwMDAwMmY2NjAzZjkwXSBbYzAwMDAwMDAw
MDAxNTg0OF0gLmtlcm5lbF90aHJlYWQrMHg1NC8weDcwDQo8Nz5tbWMwOiAgICAgKENNRDEyKTog
MDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCklORk86IHRhc2sga3dvcmtl
ci91OjI6Nzg1IGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAxMjAgc2Vjb25kcy4NCiJlY2hvIDAgPiAv
cHJvYy9zeXMva2VybmVsL2h1bmdfdGFza190aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVz
c2FnZS4NCmt3b3JrZXIvdToyICAgICBEIDAwMDAwMDAwMDAwMDAwMDAgICAgIDAgICA3ODUgICAg
ICAyIDB4MDAwMDAwMDANCkNhbGwgVHJhY2U6DQpbYzAwMDAwMDJmNjYwMzc5MF0gW2MwMDAwMDAw
MDAwMDk1MThdIC5MMQIzKzB4MmMvMHg0OA0KDQpbYzAwMDAwMDJmNjYwMzgyMF0gW2MwMDAwMDAw
MDA2NTVlMWNdIC5fX3NjaGVkdWxlKzB4MjhjLzB4NjUwDQpbYzAwMDAwMDJmNjYwM2FhMF0gW2Mw
MDAwMDAwMDA2NTYyZDBdIC5zY2hlZHVsZSsweDMwLzB4ZTANCltjMDAwMDAwMmY2NjAzYjIwXSBb
YzAwMDAwMDAwMDRjMDRjMF0gLl9fbW1jX2NsYWltX2hvc3QrMHhkMC8weDI0MA0KW2MwMDAwMDAy
ZjY2MDNjMDBdIFtjMDAwMDAwMDAwNGM0NjJjXSAubW1jX2RldGVjdCsweDNjLzB4MTEwDQpbYzAw
MDAwMDJmNjYwM2M5MF0gW2MwMDAwMDAwMDA0YzFlZWNdIC5tbWNfcmVzY2FuKzB4MzVjLzB4M2Qw
DQpbYzAwMDAwMDJmNjYwM2Q1MF0gW2MwMDAwMDAwMDAwNjlhNTBdIC5wcm9jZXNzX29uZV93b3Jr
KzB4MTgwLzB4NDkwDQpbYzAwMDAwMDJmNjYwM2UxMF0gW2MwMDAwMDAwMDAwNmE3NDBdIC53b3Jr
ZXJfdGhyZWFkKzB4MWMwLzB4NDUwDQpbYzAwMDAwMDJmNjYwM2VkMF0gW2MwMDAwMDAwMDAwNzBj
OTRdIC5rdGhyZWFkKzB4YjQvMHhjMA0KW2MwMDAwMDAyZjY2MDNmOTBdIFtjMDAwMDAwMDAwMDE1
ODQ4XSAua2VybmVsX3RocmVhZCsweDU0LzB4NzANCklORk86IHRhc2sga3dvcmtlci91OjI6Nzg1
IGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAxMjAgc2Vjb25kcy4NCiJlY2hvIDAgPiAvcHJvYy9zeXMv
a2VybmVsL2h1bmdfdGFza190aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2FnZS4NCmt3
b3JrZXIvdToyICAgICBEIDAwMDAwMDAwMDAwMDAwMDAgICAgIDAgICA3ODUgICAgICAyIDB4MDAw
MDAwMDANCkNhbGwgVHJhY2U6DQpbYzAwMDAwMDJmNjYwMzc5MF0gW2MwMDAwMDAwMDAwMDk1MThd
IC5MMQIzKzB4MmMvMHg0OA0KW2MwMDAwMDAyZjY2MDM4MjBdIFtjMDAwMDAwMDAwNjU1ZTFjXSAu
X19zY2hlZHVsZSsweDI4Yy8weDY1MA0KW2MwMDAwMDAyZjY2MDNhYTBdIFtjMDAwMDAwMDAwNjU2
MmQwXSAuc2NoZWR1bGUrMHgzMC8weGUwDQpbYzAwMDAwMDJmNjYwM2IyMF0gW2MwMDAwMDAwMDA0
YzA0YzBdIC5fX21tY19jbGFpbV9ob3N0KzB4ZDAvMHgyNDANCltjMDAwMDAwMmY2NjAzYzAwXSBb
YzAwMDAwMDAwMDRjNDYyY10gLm1tY19kZXRlY3QrMHgzYy8weDExMA0KW2MwMDAwMDAyZjY2MDNj
OTBdIFtjMDAwMDAwMDAwNGMxZWVjXSAubW1jX3Jlc2NhbisweDM1Yy8weDNkMA0KW2MwMDAwMDAy
ZjY2MDNkNTBdIFtjMDAwMDAwMDAwMDY5YTUwXSAucHJvY2Vzc19vbmVfd29yaysweDE4MC8weDQ5
MA0KW2MwMDAwMDAyZjY2MDNlMTBdIFtjMDAwMDAwMDAwMDZhNzQwXSAud29ya2VyX3RocmVhZCsw
eDFjMC8weDQ1MA0KW2MwMDAwMDAyZjY2MDNlZDBdIFtjMDAwMDAwMDAwMDcwYzk0XSAua3RocmVh
ZCsweGI0LzB4YzANCltjMDAwMDAwMmY2NjAzZjkwXSBbYzAwMDAwMDAwMDAxNTg0OF0gLmtlcm5l
bF90aHJlYWQrMHg1NC8weDcwDQo8Nz5zZGhjaSBbc2RoY2lfZGF0YV9pcnEoKV06IG1tYzA6IERN
QSBiYXNlIDB4MTE1ZTAwMDAsIHRyYW5zZmVycmVkIDB4MDIwMDAwIGJ5dGVzLCBuZXh0IDB4MTE2
MDAwMDANCklORk86IHRhc2sga3dvcmtlci91OjI6Nzg1IGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAx
MjAgc2Vjb25kcy4NCiJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVsL2h1bmdfdGFza190aW1lb3V0
X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2FnZS4NCmt3b3JrZXIvdToyICAgICBEIDAwMDAwMDAw
MDAwMDAwMDAgICAgIDAgICA3ODUgICAgICAyIDB4MDAwMDAwMDANCkNhbGwgVHJhY2U6DQpbYzAw
MDAwMDJmNjYwMzc5MF0gW2MwMDAwMDAwMDAwMDk1MThdIC5MMQIzKzB4MmMvMHg0OA0KW2MwMDAw
MDAyZjY2MDM4MjBdIFtjMDAwMDAwMDAwNjU1ZTFjXSAuX19zY2hlZHVsZSsweDI4Yy8weDY1MA0K
W2MwMDAwMDAyZjY2MDNhYTBdIFtjMDAwMDAwMDAwNjU2MmQwXSAuc2NoZWR1bGUrMHgzMC8weGUw
DQpbYzAwMDAwMDJmNjYwM2IyMF0gW2MwMDAwMDAwMDA0YzA0YzBdIC5fX21tY19jbGFpbV9ob3N0
KzB4ZDAvMHgyNDANCltjMDAwMDAwMmY2NjAzYzAwXSBbYzAwMDAwMDAwMDRjNDYyY10gLm1tY19k
ZXRlY3QrMHgzYy8weDExMA0KW2MwMDAwMDAyZjY2MDNjOTBdIFtjMDAwMDAwMDAwNGMxZWVjXSAu
bW1jX3Jlc2NhbisweDM1Yy8weDNkMA0KW2MwMDAwMDAyZjY2MDNkNTBdIFtjMDAwMDAwMDAwMDY5
YTUwXSAucHJvY2Vzc19vbmVfd29yaysweDE4MC8weDQ5MA0KW2MwMDAwMDAyZjY2MDNlMTBdIFtj
MDAwMDAwMDAwMDZhNzQwXSAud29ya2VyX3RocmVhZCsweDFjMC8weDQ1MA0KW2MwMDAwMDAyZjY2
MDNlZDBdIFtjMDAwMDAwMDAwMDcwYzk0XSAua3RocmVhZCsweGI0LzB4YzANCltjMDAwMDAwMmY2
NjAzZjkwXSBbYzAwMDAwMDAwMDAxNTg0OF0gLmtlcm5lbF90aHJlYWQrMHg1NC8weDcwDQo8Nz5z
ZGhjaSBbc2RoY2lfaXJxKCldOiAqKiogbW1jMCBnb3QgaW50ZXJydXB0OiAweDAwMDAwMDAxDQpJ
TkZPOiB0YXNrIGt3b3JrZXIvdToyOjc4NSBibG9ja2VkIGZvciBtb3JlIHRoYW4gMTIwIHNlY29u
ZHMuDQoiZWNobyAwID4gL3Byb2Mvc3lzL2tlcm5lbC9odW5nX3Rhc2tfdGltZW91dF9zZWNzIiBk
aXNhYmxlcyB0aGlzIG1lc3NhZ2UuDQprd29ya2VyL3U6MiAgICAgRCAwMDAwMDAwMDAwMDAwMDAw
ICAgICAwICAgNzg1ICAgICAgMiAweDAwMDAwMDAwDQpDYWxsIFRyYWNlOg0KW2MwMDAwMDAyZjY2
MDM3OTBdIFtjMDAwMDAwMDAwMDA5NTE4XSAuTDECMysweDJjLzB4NDgNCltjMDAwMDAwMmY2NjAz
ODIwXSBbYzAwMDAwMDAwMDY1NWUxY10gLl9fc2NoZWR1bGUrMHgyOGMvMHg2NTANCltjMDAwMDAw
MmY2NjAzYWEwXSBbYzAwMDAwMDAwMDY1NjJkMF0gLnNjaGVkdWxlKzB4MzAvMHhlMA0KW2MwMDAw
MDAyZjY2MDNiMjBdIFtjMDAwMDAwMDAwNGMwNGMwXSAuX19tbWNfY2xhaW1faG9zdCsweGQwLzB4
MjQwDQpbYzAwMDAwMDJmNjYwM2MwMF0gW2MwMDAwMDAwMDA0YzQ2MmNdIC5tbWNfZGV0ZWN0KzB4
M2MvMHgxMTANCltjMDAwMDAwMmY2NjAzYzkwXSBbYzAwMDAwMDAwMDRjMWVlY10gLm1tY19yZXNj
YW4rMHgzNWMvMHgzZDANCltjMDAwMDAwMmY2NjAzZDUwXSBbYzAwMDAwMDAwMDA2OWE1MF0gLnBy
b2Nlc3Nfb25lX3dvcmsrMHgxODAvMHg0OTANCltjMDAwMDAwMmY2NjAzZTEwXSBbYzAwMDAwMDAw
MDA2YTc0MF0gLndvcmtlcl90aHJlYWQrMHgxYzAvMHg0NTANCltjMDAwMDAwMmY2NjAzZWQwXSBb
YzAwMDAwMDAwMDA3MGM5NF0gLmt0aHJlYWQrMHhiNC8weGMwDQpbYzAwMDAwMDJmNjYwM2Y5MF0g
W2MwMDAwMDAwMDAwMTU4NDhdIC5rZXJuZWxfdGhyZWFkKzB4NTQvMHg3MA0KSU5GTzogdGFzayBr
d29ya2VyL3U6Mjo3ODUgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMCBzZWNvbmRzLg0KImVjaG8g
MCA+IC9wcm9jL3N5cy9rZXJuZWwvaHVuZ190YXNrX3RpbWVvdXRfc2VjcyIgZGlzYWJsZXMgdGhp
cyBtZXNzYWdlLg0Ka3dvcmtlci91OjIgICAgIEQgMDAwMDAwMDAwMDAwMDAwMCAgICAgMCAgIDc4
NSAgICAgIDIgMHgwMDAwMDAwMA0KQ2FsbCBUcmFjZToNCltjMDAwMDAwMmY2NjAzNzkwXSBbYzAw
MDAwMDAwMDAwOTUxOF0gLkwxAjMrMHgyYy8weDQ4DQpbYzAwMDAwMDJmNjYwMzgyMF0gW2MwMDAw
MDAwMDA2NTVlMWNdIC5fX3NjaGVkdWxlKzB4MjhjLzB4NjUwDQpbYzAwMDAwMDJmNjYwM2FhMF0g
W2MwMDAwMDAwMDA2NTYyZDBdIC5zY2hlZHVsZSsweDMwLzB4ZTANCltjMDAwMDAwMmY2NjAzYjIw
XSBbYzAwMDAwMDAwMDRjMDRjMF0gLl9fbW1jX2NsYWltX2hvc3QrMHhkMC8weDI0MA0KW2MwMDAw
MDAyZjY2MDNjMDBdIFtjMDAwMDAwMDAwNGM0NjJjXSAubW1jX2RldGVjdCsweDNjLzB4MTEwDQpb
YzAwMDAwMDJmNjYwM2M5MF0gW2MwMDAwMDAwMDA0YzFlZWNdIC5tbWNfcmVzY2FuKzB4MzVjLzB4
M2QwDQpbYzAwMDAwMDJmNjYwM2Q1MF0gW2MwMDAwMDAwMDAwNjlhNTBdIC5wcm9jZXNzX29uZV93
b3JrKzB4MTgwLzB4NDkwDQpbYzAwMDAwMDJmNjYwM2UxMF0gW2MwMDAwMDAwMDAwNmE3NDBdIC53
b3JrZXJfdGhyZWFkKzB4MWMwLzB4NDUwDQpbYzAwMDAwMDJmNjYwM2VkMF0gW2MwMDAwMDAwMDAw
NzBjOTRdIC5rdGhyZWFkKzB4YjQvMHhjMA0KW2MwMDAwMDAyZjY2MDNmOTBdIFtjMDAwMDAwMDAw
MDE1ODQ4XSAua2VybmVsX3RocmVhZCsweDU0LzB4NzANCjw3Pm1tYzA6ICAgICAoQ01EMTIpOiAw
OiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KPDc+c2RoY2kgW3NkaGNpX2ly
cSgpXTogKioqIG1tYzAgZ290IGludGVycnVwdDogMHgwMDAwMDAwMg0KPDc+bW1jMDogcmVxIGRv
bmUgKENNRDEzKTogMDogMDAwMDA5MDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCjw3PnNk
aGNpIFtzZGhjaV9kYXRhX2lycSgpXTogbW1jMDogRE1BIGJhc2UgMHgxMzZiMDAwMCwgdHJhbnNm
ZXJyZWQgMHgwNTAwMDAgYnl0ZXMsIG5leHQgMHgxMzcwMDAwMA0K

--_002_99E897753B6F7048BD8CCDB4661D02E1208C71039SN2MPN1022039d_--
