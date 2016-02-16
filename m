From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH v2] mmc-utils: Merge the lsmmc tool into mmc-utils
Date: Tue, 16 Feb 2016 20:02:15 +0000
Message-ID: <86fuwse854.fsf@void.printf.net>
References: <32aeb1c8c24a29aabe3f58bcdf60faf7a39c6491.1454660477.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([192.34.86.38]:52897 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230AbcBPUhh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Feb 2016 15:37:37 -0500
In-Reply-To: <32aeb1c8c24a29aabe3f58bcdf60faf7a39c6491.1454660477.git.baolin.wang@linaro.org>
	(Baolin Wang's message of "Fri, 5 Feb 2016 16:23:34 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, sebras@gmail.com

Hi everyone,

Sorry, I'm missing something hopefully-obvious about this patch:

Which command does someone use to run the new ext_csd code in lsmmc?

I thought that this patch would add lsmmc's ext_csd parsing to the
existing "mmc extcsd read" command.  But it doesn't seem to do that --
it duplicates the code, so there are two separate, unrelated extcsd
parsers in:

    * lsmmc.c:print_mmc_ext_csd()
    * mmc_cmds.c:do_read_extcsd().

I don't think that's what Ulf's suggestion intended -- as I read it,
he was hoping to see the parsers merged to make one better parser.
I'd like to see that too, though I understand that it's more work.

And I'm still confused, as above, about how to actually use the new
extcsd parser, because "mmc extcsd read" doesn't seem to be it, and
the new commands added:

    int do_read_scr(int argc, char **argv);
    int do_read_cid(int argc, char **argv);
    int do_read_csd(int argc, char **argv);

.. don't seem to be it either, since they don't pass "EXT_CSD" to
process_dir(), which is the only way I can see to activate lsmmc's
ext_csd printer.  How's it supposed to work?

Also:

On Fri, Feb 05 2016, Baolin Wang wrote:
> +void usage(void)
> +int parse_opts(int argc, char **argv, struct config *config)

These functions could be totally removed now, I think?

Thanks!

- Chris.
-- 
Chris Ball   <http://printf.net/>
