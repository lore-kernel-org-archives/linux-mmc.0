From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [QUESTION] mmc: mmci: Howto merge patches
Date: Mon, 17 Dec 2012 16:29:51 +0100
Message-ID: <CAPDyKFpXyVCzFWkyL3+92Zb9hoyKaEV4hpaUYO9O5o71nNmk8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:50549 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab2LQP3x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 10:29:53 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so2102088wib.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Dec 2012 07:29:52 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

Hi Russell and Chris,

I would like to propose a change of how we handle mmci patches to be
merged. Instead of going through Russell's arm tree, I would like
Chris to handle the merge through his mmc tree.

The reason is simply that patches can have dependencies to the
protocol layer and in seems a bit unnecessary to wait for another
merge window to occur to handle these patches.
Moreover, if most of the mmci patches goes through Chris mmc tree, I
believe we would minimize the number of possible conflicts. Russell
will then only need to NACK patches to prevent them from being merged.

Do you think this could be and acceptable setup for both of you?

Kind regards
Ulf Hansson
