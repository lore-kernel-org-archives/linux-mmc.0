From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: use io functions from sdhci.h
Date: Mon, 17 Jul 2017 09:26:22 -0400
Message-ID: <EA8CC489-5889-42AD-B43E-0CDDF9EFAB4D@gmail.com>
References: <20170717012332.16505-1-jeff.dagenais@gmail.com> <60af517b-4a86-9150-901f-7e640bb517d9@xilinx.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:34161 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdGQN0Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jul 2017 09:26:24 -0400
Received: by mail-io0-f169.google.com with SMTP id r36so42972142ioi.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jul 2017 06:26:24 -0700 (PDT)
In-Reply-To: <60af517b-4a86-9150-901f-7e640bb517d9@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-mmc@vger.kernel.org


> On Jul 17, 2017, at 02:33, Michal Simek <michal.simek@xilinx.com> =
wrote:
>=20
> Information about patch version shouldn't be the part of commit =
message
> but they should be placed below ---.

Sorry, still perfecting this mailing patches art. Wish it was merge =
requests on
github... less decorum and chances to get it wrong!

I had put the "-v2" switch on "git send-email" but it didn't appear in =
the
commit msg??

Also, I got a "kbuild test robot" build regression notice, but the =
contained
errors seem unrelated to my patch... Should I do anything about that?

Should I formulate a v3?=
