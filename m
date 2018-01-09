From: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Subject: Re: [PATCH v3] mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Tue,  9 Jan 2018 13:43:47 +0100 (CET)
Message-ID: <OFF01FF0C5.FD711E89-ONC1258210.0044F6F1-C1258210.0045ED0A@rittal.de>
References: <CACRpkdYW36Kdi1DuF+TbNsQNwT1RWOmVMfs0jJ-Ssf+LCembTg@mail.gmail.com>,
        <20180105162936.18612-1-linus.walleij@linaro.org> <CAPDyKFo+r39NAW1qGaXxq3_9kr9dVU8DBEuhQBtg-n4r4JFzAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw03.loh-group.com ([195.226.74.51]:43016 "EHLO
        mailgw03.loh-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeAIMnt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jan 2018 07:43:49 -0500
In-Reply-To: <CACRpkdYW36Kdi1DuF+TbNsQNwT1RWOmVMfs0jJ-Ssf+LCembTg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?ISO-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, "# 4.0+" <stable@vger.kernel.org>

> Is using 512 insead of 64KB a problem on any target system? 
> Hardly on x86 laptops, but what about i.MX25 and i.MX35?

I can tell you that we won't have a problem with this size,
but this is only my opinion and we have just one device
with the i.MX25 architecture.

Kind regards,
Benjamin Beckmeyer
