From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v3] mmc: Add ioctl to let userspace apps send ACMDs
Date: Fri, 8 Apr 2011 03:22:42 -0500
Message-ID: <BANLkTin9hfr+VfprkDr-Lc+iY0qShmcnng@mail.gmail.com>
References: <alpine.DEB.2.00.1104071816270.10238@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:44049 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab1DHIWp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2011 04:22:45 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p388N5HS001119
	for <linux-mmc@vger.kernel.org>; Fri, 8 Apr 2011 04:23:05 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p388FnoY028672
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 8 Apr 2011 04:23:04 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so4480719wyb.15
        for <linux-mmc@vger.kernel.org>; Fri, 08 Apr 2011 01:22:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104071816270.10238@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi John,

On Thu, Apr 7, 2011 at 8:18 PM, John Calixto
<john.calixto@modsystems.com> wrote:
> + =A0 =A0 =A0 /* data.flags must already be set before doing this. */
> + =A0 =A0 =A0 mmc_set_data_timeout(&data, card);
> + =A0 =A0 =A0 /* Allow overriding the timeout_ns for empirical tuning=
=2E */
> + =A0 =A0 =A0 if (idata->ic.force_timeout_ns)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data.timeout_ns =3D idata->ic.force_tim=
eout_ns;
> +

Are there any R1B ACMDs?

> + =A0 =A0 =A0 mmc_wait_for_req(card->host, &mrq);
> +
> + =A0 =A0 =A0 if (cmd.error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(card->host), "%s: cmd e=
rror %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 __func__, cmd.error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D cmd.error;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto acmd_rel_host;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (data.error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(card->host), "%s: data =
error %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 __func__, data.error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D data.error;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto acmd_rel_host;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* According to the SD specs, some commands require a=
 delay after
> + =A0 =A0 =A0 =A0* issuing the command.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (idata->ic.postsleep_us)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(idata->ic.postsleep_us);
> +

How long can this possibly be? Does usleep make any sense here?

>
 +struct mmc_ioc_cmd {
> + =A0 =A0 =A0 int write_flag; =A0/* implies direction of data. =A0tru=
e =3D write, false =3D read */
> + =A0 =A0 =A0 __u32 opcode;
> + =A0 =A0 =A0 __u32 arg;
> + =A0 =A0 =A0 __u32 response[4]; =A0/* CMD response */
> + =A0 =A0 =A0 unsigned int flags;
> + =A0 =A0 =A0 unsigned int blksz;
> + =A0 =A0 =A0 unsigned int blocks;

I'm not sure I understand why blksz is passed. If you needed to set
the block size (via CMD16) prior to some command (like MMC password
protection) I could kind of get it, but then all I see the blk size
getting used for is calculating the data amount in bytes, so you're
not doing that. So why not just infer it from the card queue?

A
