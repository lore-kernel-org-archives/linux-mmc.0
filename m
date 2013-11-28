From: Romain Izard <romain.izard.pro@gmail.com>
Subject: =?UTF-8?Q?e=E2=8B=85MMC_forward_compatibility?=
Date: Thu, 28 Nov 2013 15:01:49 +0100
Message-ID: <CAGkQfmOjUeKYMq8aosZTyco4Sna4yM_20zGWUG2nWRyX_gwyhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:44543 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab3K1OCL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Nov 2013 09:02:11 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so9300803oag.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 Nov 2013 06:02:10 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Hello,

The e=E2=8B=85MMC 5.0 specification has been published by JEDEC on Sept=
ember
2013 [1], and contains a note in section B.8, which says: "A host
system should work properly considering future eMMC version. For
example, a host system is expected not to exit only due to the
EXT_CSD_REV[192] value greater than 7 which will be used for next
e=E2=80=A2MMC revision."

Right now, the kernel controls the value of both fields 192 and 194,
and rejects any device where CSD_STRUCTURE > 2 or EXT_CSD_REV > 7.

During the updates to the specification, JEDEC has maintained forward
compatibility, setting reserved bits in the EXT_CSD register to
describe new mandatory and optional features. If the specification
changes in an incompatible way, it is expected that the value in
CSD_STRUCTURE will change. As a result, I believe it would not be an
issue to remove the control on EXT_CSD_REV.

I propose this change because e=E2=8B=85MMC manufacturers are rapidly c=
hanging
available references, and products with a long production life can
encounter the situation where the kernel image, frozen at the
beginning of the production, cannot support newer chips only because
of this rule.


[1] http://www.jedec.org/standards-documents/docs/jesd84-b50 (Free
registration required)

Best regards,
--=20
Romain Izard
