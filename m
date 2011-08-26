From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 0/2] eMMC v4.5 feature supports
Date: Fri, 26 Aug 2011 09:08:53 +0900
Message-ID: <CAH9JG2VyBR+Cb48bnQZjF96NNuZqbbScYhgjLmZ9kdQP3iFhbQ@mail.gmail.com>
References: <20110808021113.GA20317@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53781 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab1HZAIy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2011 20:08:54 -0400
Received: by qwk3 with SMTP id 3so1692106qwk.19
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2011 17:08:54 -0700 (PDT)
In-Reply-To: <20110808021113.GA20317@july>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: jh80.chung@samsung.com, arnd@arndb.de

Hi Chris,

Any comments on eMMC v4.5 supports?

Thank you,
Kyungmin Park

On Mon, Aug 8, 2011 at 11:11 AM, Kyungmin Park <kmpark@infradead.org> w=
rote:
> New feature, discard and sanitize supports
>
> See the detail information at each patch
>
> Kyungmin Park (2):
> =A0mmc: core: new discard feature support at mmc v4.5
> =A0mmc: core: mmc sanitize feature support for v4.5
>
> =A0drivers/mmc/card/block.c | =A0 13 +++++++++++--
> =A0drivers/mmc/card/queue.c | =A0 =A02 +-
> =A0drivers/mmc/core/core.c =A0| =A0 22 ++++++++++++++++++++++
> =A0drivers/mmc/core/mmc.c =A0 | =A0 =A04 ++++
> =A0include/linux/mmc/card.h | =A0 =A03 +++
> =A0include/linux/mmc/core.h | =A0 =A03 +++
> =A0include/linux/mmc/mmc.h =A0| =A0 =A02 ++
> =A07 files changed, 46 insertions(+), 3 deletions(-)
>
> --
> 1.7.5.1.300.gc565c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
