From: sami md <sami.md.ko@gmail.com>
Subject: how to implement sampling clock tuning procedure
Date: Wed, 2 Feb 2011 20:59:13 +0530
Message-ID: <AANLkTikBw-P2Abf7VtfWjqZ=ziMmDQRQCYADBhCH7eQK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44112 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab1BBP3O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Feb 2011 10:29:14 -0500
Received: by iwn9 with SMTP id 9so75516iwn.19
        for <linux-mmc@vger.kernel.org>; Wed, 02 Feb 2011 07:29:13 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi All,

=A0 =A0 I need to implement sampling clock tuning procedure in mode-1.
=A0 =A0 I have created a timer with initial value taken from "timer cou=
nt" field
=A0 =A0 from caps register, when the timer expires i set the expiration=
 flag.

    on receiving a command request the host driver checks the expiratio=
n flag
=A0 =A0 and if the flag is set the host driver should perform tuning pr=
ocedure by
=A0 =A0 issuing CMD19 before the command request until buffer read read=
y.

=A0 =A0 my doubt are:

    =A0 =A0 =A01) can i call tuning procedure from "sdhci_request".
=A0 =A0 =A0 =A0 =A02) how to issue CMD19.
=A0 =A0 =A0 =A0 =A03) is there any patch available for tuning procedure=
=2E

Thanks
