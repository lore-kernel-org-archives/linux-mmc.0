From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] arm: mmci: Add ARM variant with extended FIFO
Date: Thu, 17 Mar 2011 09:54:32 +0100
Message-ID: <AANLkTimV7eqzRNwoJ8Hoc_dvMKpsOPwW7d9TvNJ2SMR9@mail.gmail.com>
References: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37588 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936Ab1CQIyd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2011 04:54:33 -0400
Received: by qyk7 with SMTP id 7so4167979qyk.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2011 01:54:32 -0700 (PDT)
In-Reply-To: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On Fri, Mar 11, 2011 at 6:18 PM, Pawel Moll <pawel.moll@arm.com> wrote:

> New IO FPGA implementation for Versatile Express boards contain
> MMCI (PL180) cell with FIFO extended to 128 words (512 bytes).

OK that's the quick fix, and deeper FIFOs are always nice.

If your hardware engineers are listening, I suggest that hardware clock
gating (as suggested in some earlier mail) plus DMA engine support will
yet improve this by orders of magnitude and also bring you less errors.

Linus Walleij
