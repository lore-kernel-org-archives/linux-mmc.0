Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15427C7EE23
	for <linux-mmc@archiver.kernel.org>; Tue, 23 May 2023 11:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbjEWLqp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 May 2023 07:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjEWLqp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 May 2023 07:46:45 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8301C129
        for <linux-mmc@vger.kernel.org>; Tue, 23 May 2023 04:46:37 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C2CED3A2B76
        for <linux-mmc@vger.kernel.org>; Tue, 23 May 2023 13:46:34 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id B12013A2A99
        for <linux-mmc@vger.kernel.org>; Tue, 23 May 2023 13:46:34 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail5.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Tue, 23 May 2023 13:46:34 +0200 (CEST)
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     Enrico Jorns <ejo@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 1/2] mmc-utils: introduce optional --verify argument for
 'extcsd write'
Thread-Topic: [PATCH 1/2] mmc-utils: introduce optional --verify argument for
 'extcsd write'
Thread-Index: AQHZjPfbHb2sZ/GVkUWOW8jp0Q+bxa9nvRrA
Date:   Tue, 23 May 2023 11:46:33 +0000
Message-ID: <43b06d417c1f468da5a3d95b43638a72@hyperstone.com>
References: <20230522215310.2038669-1-ejo@pengutronix.de>
In-Reply-To: <20230522215310.2038669-1-ejo@pengutronix.de>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27644.007
X-TMASE-Result: 10--12.564000-10.000000
X-TMASE-MatchedRID: oTBA/+sdKaa9GVQT/CmkaMzWN98iBBeGQAKUX1R86jQuGuelK6gNu8Wl
        hj9iHeVpLn4HhAYjYKS0iUWY8WUfqTHClXpILVWsKiJEqUFWRggcsx3IH4sq3H16C7GFcvky6Ch
        K9oqyX+Qi+t+0AiFaYvL3NxFKQpq1YwBIYRLig/YRW4LR41Fi8hgff28UuvITqgN67rC7tuqjFx
        ofCiPjaHrdTieyml6dG6Aor8mgxBKSIU8VaO0sk54CIKY/Hg3AyJ1gFgOMhOn3IRre2/Nqdhd65
        AKojGV5IAcCikR3vq/dOdKfArIOJIHqofS8z651m/1mQrARDo7BVTk0G1tv0Un/uYM5I8OH
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: d8d8e8c8-c6e1-4166-9e73-9c9270fc0abd-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



-----Original Message-----
From: Enrico Jorns <ejo@pengutronix.de> 
Sent: Monday, May 22, 2023 11:53 PM
To: linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>; Ulf Hansson <ulf.hansson@linaro.org>; ejo@pengutronix.de
Subject: [PATCH 1/2] mmc-utils: introduce optional --verify argument for 'extcsd write'

> Registers can be write-once but ioctl does not necessarily return with an error. Thus it is a good idea to allow verifying the data written.

But it will return with an error soon, I'm working on it, anyway I think it's not a bad idea.
User needs to be aware that not all indices can be '--verify'ed, though.

> 
> Signed-off-by: Enrico Jorns <ejo@pengutronix.de>
> ---
>  mmc.c      |  7 ++++---
>  mmc_cmds.c | 28 ++++++++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/mmc.c b/mmc.c
> index 795b4e3..3f813b4 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -56,9 +56,10 @@ static struct Command commands[] = {
>  		"Print extcsd data from <device>.",
>  	  NULL
>  	},
> -	{ do_write_extcsd, 3,
> -	  "extcsd write", "<offset> <value> <device>\n"
> -		  "Write <value> at offset <offset> to <device>'s extcsd.",
> +	{ do_write_extcsd, -3,
> +	  "extcsd write", "<offset> <value> <device> [--verify]\n"
> +		  "Write <value> at offset <offset> to <device>'s extcsd.\n"
> +		  "  --verify  Verify data written",
>  	  NULL
>  	},
>  	{ do_writeprotect_boot_get, -1,
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index df66986..154020e 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1986,9 +1986,10 @@ int do_write_extcsd(int nargs, char **argv)
>  	int fd, ret;
>  	int offset, value;
>  	char *device;
> +	int verify = 0;
>  
> -	if (nargs != 4) {
> -		fprintf(stderr, "Usage: mmc extcsd write <offset> <value> </path/to/mmcblkX>\n");
> +	if (nargs != 4 && nargs != 5) {
> +		fprintf(stderr, "Usage: mmc extcsd write <offset> <value> 
> +</path/to/mmcblkX> [--verify]\n");
>  		exit(1);
>  	}
>  
> @@ -1996,6 +1997,14 @@ int do_write_extcsd(int nargs, char **argv)
>  	value  = strtol(argv[2], NULL, 0);
>  	device = argv[3];
>  
> +	if (nargs == 5) {
> +		if (strcmp(argv[4], "--verify") == 0) {
> +			verify = 1;
> +		} else {
> +			fprintf(stderr, "Unknown argument: '%s'\n", argv[4]);
> +		}
> +	}
> +
>  	fd = open(device, O_RDWR);
>  	if (fd < 0) {
>  		perror("open");
> @@ -2010,6 +2019,21 @@ int do_write_extcsd(int nargs, char **argv)
>  		exit(1);
>  	}
>  
> +	if (verify) {
> +		__u8 ext_csd[512];
> +
> +		ret = read_extcsd(fd, ext_csd);
> +		if (ret) {
> +			fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
I think this error message should indicate that the write already happened.

> +			exit(1);
> +		}
> +
> +		if (ext_csd[offset] != value) {
> +			fprintf(stderr, "Verification failed: expected 0x%x, got 0x%x\n", value, ext_csd[offset]);
> +			exit(1);
> +		}
> +	}
> +
>  	return ret;
>  }
>  
> --
> 2.39.2
>

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

