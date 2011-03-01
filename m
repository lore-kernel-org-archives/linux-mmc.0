From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Remove set-but-unused variable.
Date: Tue, 1 Mar 2011 10:07:23 +0000
Message-ID: <AANLkTimqBMmpT_vr+UHjkwzHGOJEKaNeUKLw0VZRnWjr@mail.gmail.com>
References: <1298930137-15105-1-git-send-email-cjb@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46174 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab1CAKHY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 05:07:24 -0500
Received: by pvg12 with SMTP id 12so773815pvg.19
        for <linux-mmc@vger.kernel.org>; Tue, 01 Mar 2011 02:07:24 -0800 (PST)
In-Reply-To: <1298930137-15105-1-git-send-email-cjb@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Mon, Feb 28, 2011 at 9:55 PM, Chris Ball <cjb@laptop.org> wrote:
> count is only ever used by assigning to old_len if count =3D=3D 0, an=
d
> then old_len isn't ever used at all. =A0So, both are redundant. =A0Fi=
xes:
>
> drivers/mmc/host/dw_mmc.c: In function =91dw_mci_read_data_pio=92:
> drivers/mmc/host/dw_mmc.c:1034:32: warning: variable =91old_len=92 se=
t but
> not used [-Wunused-but-set-variable]
>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> Cc: Will Newton <will.newton@imgtec.com>

Looks good, thanks for fixing this!

Acked-by: Will Newton <will.newton@imgtec.com>
