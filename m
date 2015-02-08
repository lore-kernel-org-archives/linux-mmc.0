From: "Simon Raffeiner (SCC)" <simon.raffeiner@kit.edu>
Subject: Re: "Timeout waiting for hardware interrupt" on Lenovo Thinkpad Tablet
 10
Date: Sun, 8 Feb 2015 12:54:12 +0100
Message-ID: <54D74E64.2090809@kit.edu>
References: <54CF7DCB.8070302@kit.edu> <54CF847F.3070800@m-labs.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from scc-mailout-kit-02.scc.kit.edu ([129.13.231.82]:50253 "EHLO
	scc-mailout-kit-02.scc.kit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753755AbbBHLyV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Feb 2015 06:54:21 -0500
In-Reply-To: <54CF847F.3070800@m-labs.hk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?U8OpYmFzdGllbiBCb3VyZGVhdWR1Y3E=?= <sb@m-labs.hk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hello everybody,

is there a "safe" combination of parameters for sdhci.debug_quirks and
sdhci.debug_quirks2 which should work in all cases, sacrificing perform=
ance?

regards,
Simon


Am 02.02.2015 um 15:06 schrieb S=C3=A9bastien Bourdeauducq:
> On 02/02/2015 09:38 PM, Simon Raffeiner (SCC) wrote:
>> I am currently trying to install Ubuntu 15.04
>=20
> Another bug with the Ubuntu installer on this pesky computer is it
> attempts to access the rpmb partition, fails, and aborts the
> installation. For some reason, debug_quirks2=3D0xc0 also works around=
 this
> problem.
>=20
>> the tablet also crashes if the eMMC storage is not used as the
>> root filesystem, it also happens in the live environment booted off =
the
>> USB stick, e.g. when trying to do an mkfs on one of the eMMC partiti=
ons.
>=20
> I also experienced freezes when booted from a Arch Linux USB stick
> (2015.01.01 with 3.17.6 kernel), and I gave up and went for Ubuntu wh=
ere
> strangely enough those crashes did not happen. I don't know if they a=
re
> related to the eMMC as I was not able to get any kernel message (the
> machine simply stops responding completely).
>=20
> S=C3=A9bastien
