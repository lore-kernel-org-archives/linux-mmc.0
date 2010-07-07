From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 01/12] mmci: use sg_miter API to fix multi-page sg
	handling
Date: Wed, 7 Jul 2010 22:34:17 +0200
Message-ID: <AANLkTikv1jFoRfTIVb_DtAjB-K5QqmacIA5FPB4am4SW@mail.gmail.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33290 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455Ab0GGUeU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jul 2010 16:34:20 -0400
Received: by bwz1 with SMTP id 1so63272bwz.19
        for <linux-mmc@vger.kernel.org>; Wed, 07 Jul 2010 13:34:18 -0700 (PDT)
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com

I've tested this MMCI patch set on RealView PB1176 and
U300, mounted cards, copied files back and forth, unmount
diff files. No problems.

This should cover all MMCI variants, since the PB1176 is a
vanilla ARM variant.

Just fix the comments on patch #7 and it should be ripe for
the patch tracker methinks.

Yours,
Linus Walleij
