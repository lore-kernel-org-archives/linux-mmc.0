From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 21/32] mmc: bcm2835-sdhost: Add new driver for the internal SD controller.
Date: Thu, 02 Jun 2016 11:12:38 -0700
Message-ID: <87vb1ra295.fsf@eliezer.anholt.net>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com> <1464817421-8519-22-git-send-email-kraxel@redhat.com> <4715245.LFBOAeJdHc@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:37549 "EHLO anholt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbcFBSMl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 2 Jun 2016 14:12:41 -0400
In-Reply-To: <4715245.LFBOAeJdHc@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-rpi-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>

--=-=-=
Content-Type: text/plain

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday, June 1, 2016 11:43:30 PM CEST Gerd Hoffmann wrote:
>> +	/* Parse OF address directly to get the physical address for
>> +	 * DMA to our registers.
>> +	 */
>> +	host->phys_addr = be32_to_cpup(of_get_address(pdev->dev.of_node, 0,
>> +						      NULL, NULL));
>
> This looks broken on 64-bit systems when #address-cells=<2>, or if there
> is an intermediate bus with a non-empty ranges property.
>
> What's wrong with platform_get_resource(pdev, IORESOURCE_MEM, 0)?

I'll get to the rest of the review later, but this is a weird pattern
that we have in several bcm2835-related drivers.

We need the address as seen by the DMA controller, not the address from
the ARM's perspective (which is offset by the dma-ranges DT property).
This is the way that people have figured out to get that address.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXUHcWAAoJELXWKTbR/J7oqFYQAIJSbUjr0aki/jgcbQghZyE2
Q65TWO+XHTrXx+gjO07w8dajqJVnX935X0q/NPkuP890GpB62GjtxtmT3NtI5Qp9
yJG2c/R8xk/VDraeowlx5402MrfhgJKjLHFNlQ83h7YW/VPHztcnlMgRnAu4CiN/
j8wKWM/j+SY1hxxRACSqL9Bq2HaNMi4Jhv27BlfJfyh3TGSS7zX1JTB5lU878aTT
1CVNdXQB34Jfg4upsynPYVeGEzoCA+kKQ0ecsAz1jyT7vE5qvTr12XicetCfaDLR
Q/W2LmBSsxZHKj5SWZii0J/u2UUhzzFWn6R5jUSV8wb+i0j2BCKLXXrTgIhd0Dal
MSwTdhOwGvkdiuekDszRTwgs8vLAeoaDKtjxxitzAyBoXzK6QYyBQ4vR0K+/JGPO
SJy42YQXHqVhJP2F6PfTojf5xw195v/ma7mtqO0abOlOE03+MfeL+oDxmLbY4xAr
ZagbB3WXOo2A9TWlz9VPCJ/ivQo/R61xZZk9as4d6ikiMT/J7JB42vUt08q9a0SH
bZW/GxIoQlXdvUX+5E+9WLOkJ41nusJOF0B2QcK+mR1TSxSFWwTXJu3fTjA5EqF/
5VOH6Et131E/pkeZyqJZ9BuFUZ8J47p+CZxNaBm7rty+xakvTs3x72h+dpRMBMdc
5qm95SQjk3eLgWeJDxxz
=eWjB
-----END PGP SIGNATURE-----
--=-=-=--
