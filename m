From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: card: move variable initialization earlier
Date: Tue, 3 Apr 2012 12:57:11 +0200
Message-ID: <CACRpkdbfHoQisGL4Mb905dfQDKZCaSYiG54PSK3DW7yb9Wx0DQ@mail.gmail.com>
References: <1332495146-16312-1-git-send-email-linus.walleij@linaro.org>
	<8762dkm6wc.fsf@laptop.org>
	<4F7AB768.8020702@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36404 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab2DCK5M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Apr 2012 06:57:12 -0400
Received: by yenl12 with SMTP id l12so1649559yen.19
        for <linux-mmc@vger.kernel.org>; Tue, 03 Apr 2012 03:57:11 -0700 (PDT)
In-Reply-To: <4F7AB768.8020702@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>, Rabin Vincent <rabin@rab.in>, Kyungmin Park <kyungmin.park@samsung.com>, Kyungmin Park <kmpark@infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>

On Tue, Apr 3, 2012 at 10:40 AM, Adrian Hunter <adrian.hunter@intel.com=
> wrote:

>> I think you (Adrian) introduced this "goto out->goto retry" logic in
>> upstream commit 67716327eec7e9 -- please could you take a look here?
>
> The sanitize logic looks wrong to me. =A0I would expect it to look
> like this:

Hm it looks like that compile warning opens a can of worms.
Can you cook a patch we can test? Would be much appreciated.

Not that I have any eMMC 4.5 card, but I think some others on CC have..=
=2E

Yours,
Linus Walleij
