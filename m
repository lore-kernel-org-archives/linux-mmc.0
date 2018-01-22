From: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Subject: Re: [PATCH v6] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Mon, 22 Jan 2018 10:59:21 +0100 (CET)
Message-ID: <OF8563613A.5338B5FD-ONC125821D.0036DEFF-C125821D.0036DF00@rittal.de>
References: <CACRpkdatPkr0Y-FvegwXMJB41nmN-KArXhwpZj0nR9f7SyyvmQ@mail.gmail.com>,
        <20180119145303.4097-1-linus.walleij@linaro.org> <OFE718A5EC.F4E3005B-ONC125821D.00225D5B-C125821D.00229F17@rittal.de> <CACRpkdYZMa7-F8pR8rKHKfXgqRMFknniLDr-vtQ-BW2fZLk+qw@mail.gmail.com> <OF64BA4616.A552893D-ONC125821D.002E9E83-C125821D.002EFBB2@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw03.loh-group.com ([195.226.74.51]:60072 "EHLO
        mailgw03.loh-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeAVJ7X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jan 2018 04:59:23 -0500
In-Reply-To: <CACRpkdatPkr0Y-FvegwXMJB41nmN-KArXhwpZj0nR9f7SyyvmQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?ISO-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, stable <stable@vger.kernel.org>

> OK that doesn't work. Scratch that patch. What about this instead?

That is working.
I did some quick testing with time and dd again.

#time dd if=/dev/zero of=test bs=1M count=4
real	0m1.898s
user	0m0.002s
sys	0m0.392s

#time dd if=/dev/zero of=test bs=1M count=8
real	0m5.292s
user	0m0.004s
sys	0m0.772s

#time dd if=/dev/zero of=test bs=1M count=16
real	0m10.130s
user	0m0.009s
sys	0m1.479s

#time dd if=/dev/zero of=test bs=1M count=32
real	0m18.752s
user	0m0.001s
sys	0m2.934s

Looks good to me. So far.

Kind regards,
Benjamin Beckmeyer
