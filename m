From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2] mmc-utils: Merge the lsmmc tool into mmc-utils
Date: Wed, 17 Feb 2016 10:31:13 +0800
Message-ID: <CAMz4kuLnLeERAsM_piro_q_+V2P+OfjxNROKYNaSBr7qEUQ7bQ@mail.gmail.com>
References: <32aeb1c8c24a29aabe3f58bcdf60faf7a39c6491.1454660477.git.baolin.wang@linaro.org>
	<86fuwse854.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36625 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965038AbcBQCbO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Feb 2016 21:31:14 -0500
Received: by mail-yw0-f178.google.com with SMTP id e63so2702638ywc.3
        for <linux-mmc@vger.kernel.org>; Tue, 16 Feb 2016 18:31:13 -0800 (PST)
In-Reply-To: <86fuwse854.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Rasmussen <sebras@gmail.com>

On 17 February 2016 at 04:02, Chris Ball <chris@printf.net> wrote:
> Hi everyone,
>
> Sorry, I'm missing something hopefully-obvious about this patch:
>
> Which command does someone use to run the new ext_csd code in lsmmc?
>
> I thought that this patch would add lsmmc's ext_csd parsing to the
> existing "mmc extcsd read" command.  But it doesn't seem to do that --
> it duplicates the code, so there are two separate, unrelated extcsd
> parsers in:
>
>     * lsmmc.c:print_mmc_ext_csd()
>     * mmc_cmds.c:do_read_extcsd().
>
> I don't think that's what Ulf's suggestion intended -- as I read it,
> he was hoping to see the parsers merged to make one better parser.
> I'd like to see that too, though I understand that it's more work.
>
> And I'm still confused, as above, about how to actually use the new
> extcsd parser, because "mmc extcsd read" doesn't seem to be it, and
> the new commands added:
>
>     int do_read_scr(int argc, char **argv);
>     int do_read_cid(int argc, char **argv);
>     int do_read_csd(int argc, char **argv);
>
> .. don't seem to be it either, since they don't pass "EXT_CSD" to
> process_dir(), which is the only way I can see to activate lsmmc's
> ext_csd printer.  How's it supposed to work?

I want to merge the lsmmc code into mmc-utils firstly, then start to
modify the extcsd parser, but that seems not a good plan.

I'm also confused how to make one better extcsd parser. Remove the
do_read_extcsd() function in mmc_cmds.c file replacing with
print_mmc_ext_csd() function? Or merge the parser of
print_mmc_ext_csd() into do_read_extcsd(), then remove the
print_mmc_ext_csd() function? But I think it is not compatible to
merge different parser style together.

>
> Also:
>
> On Fri, Feb 05 2016, Baolin Wang wrote:
>> +void usage(void)
>> +int parse_opts(int argc, char **argv, struct config *config)
>
> These functions could be totally removed now, I think?

But there is one '- v' parameter, we just enable 'verbose' all the
time with removing the '-v' parameter?

>
> Thanks!
>
> - Chris.
> --
> Chris Ball   <http://printf.net/>



-- 
Baolin.wang
Best Regards
