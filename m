From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [bug report] mmc: block: return errorcode from mmc_sd_num_wr_blocks()
Date: Mon, 13 Feb 2017 15:41:29 +0100
Message-ID: <CACRpkdaZTAKO8sb436A0tMvNWYQYGJyUgoA+EYdC81SCZ_mgBw@mail.gmail.com>
References: <20170207082316.GA25804@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:33255 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbdBMOlb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2017 09:41:31 -0500
Received: by mail-it0-f42.google.com with SMTP id d9so8076945itc.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2017 06:41:31 -0800 (PST)
In-Reply-To: <20170207082316.GA25804@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Feb 7, 2017 at 9:23 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:

>    785          if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD))
>    786                  return 0;
>
> This is supposed to be "return -EIO", I suspect.  The caller expects
> that *written_blocks is initialized if we return zero.

Indeed. I sent a fixup patch.

Thank you so much for noticing this and reporting!

Yours,
Linus Walleij
