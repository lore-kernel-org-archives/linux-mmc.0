From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: renesas sdhi driver and DMA
Date: Wed, 11 Oct 2017 01:26:31 +0000
Message-ID: <SG2PR06MB1165529F4559C7D6CD23CA9C8A4A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <SG2PR06MB1165F16A63D6793DBEC419688A750@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171010203229.rrwxkrczuk7piqh6@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:53539 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751156AbdJKB0j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Oct 2017 21:26:39 -0400
In-Reply-To: <20171010203229.rrwxkrczuk7piqh6@tetsubishi>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Wolfram,

On Tuesday, October 10, 2017, Wolfram Sang wrote:
> Isn't it SYS-DMAC compatible (sigh)?

And to answer your question, it's a completely different IP than the=20
SYS-DMAC. It's still a multi-channel linked-list descriptor based system=20
like SYS-DMAC, but a complete different set of registers.

However, it's a nice piece of IP so we'll probably continue to use it=20
for future RZ/A devices.


Chris
