Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86080C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 09:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A1A207FB
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 09:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ACyRCIzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgEVJJX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 05:09:23 -0400
Received: from mout.web.de ([212.227.15.4]:51537 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbgEVJJW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 22 May 2020 05:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590138548;
        bh=nBwsoM4qHYCtDnO8ZRhtCYIcZPMj93WTDzYumOpqh3k=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=ACyRCIzcsM8D7SQCp/xkgYlbb/W0LmNevQV/tj14h4wNgq2SexGGBSNTCmux23Y+x
         I3jl38PiN39FFz9gC3OM77X/oo7q/NUTFaT5wvKaBB4yIcPRhCYYjjPEmOJPTvhxeL
         hctZKOBTxUmbVM6rMHGMIHuaSOAfwp6HdOyrdeDs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.165.155]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lm4jx-1j2RsL2Og5-00Zgkr; Fri, 22
 May 2020 11:09:08 +0200
To:     Peng Hao <richard.peng@oppo.com>, linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Fix use after free in mmc_rpmb_chrdev_release()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e5af0076-7386-c6d9-960a-1b6b29141bfe@web.de>
Date:   Fri, 22 May 2020 11:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LrwXE7KQ7dbO2laMuBn/doDZ4NK42EEdVqBcyA60kDZbzNdeQjT
 udv+rvVPVPuYVjBl42PLir7oW7Xh7xuZJH6IfI5SybsaT+e0W5NEYEcxyh/FXlQjmb1aR2X
 Qm3KIYJkImF2uOPUk2Sdj8DS7DSQBRkFivjUyA1cCaPQmpL3khUmVA8tL/ku00Rw7D/OYEP
 CxSC/Zmly3I0rNi8qgwPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K3ogYrHgq88=:Iuhir0DOgtlq0bNgAxERKV
 GP06VZQI67CJNb/nd0yKShEbws7zMQDzZ703dBK+jY/VdRRQPSV2M7lIlUKqeKXCwLlB2PJHp
 6RD5AwhNp3u8SbMZlIDyJd58/iZ245UAulVKbFzwv9vkNyo6PakgrU+/8vn/Fb5PLPQMo7Azy
 wb2gQBNTlj8D3l2Ip1RbVue3s7Z/jJDfgEKDfIUZJaYFO7KuOEB9RNlk7Z0XlHd8b5DSZxVb0
 2i+wnWbIvHUoEDrwSWdA+gLdxrz+QiNfkv5fmRCdP/tioHly2nLix9A57M2Hh+3oarto/bvJX
 NQYwK4/P6syx+2I59zUm+FsrN28Oty4s7h5KjSJd5NYHE2h97n2FwBkYOeGsvUuxGO7l9Zlml
 6f2BrWHNrKOdiWdh4SmfM08YoM2fj98BJHis6mXQ9e+jXwYq6YHrUtaVLhDm2n9BDAu7vFgfv
 KoLxDl7jIo2MxyMiqZJ18StUuMcrVDv/Vb0ZSAqpawSFG19UYPWg8W2e1a2xw89Ojlgzatlvg
 x6hna1O4fMMWFWfVOI873PrQDcVu1bZNQSt033La4tir8uHz0faxsAzCmWkkX2J2rJlItu7qX
 6Yhkc0NaTZFcXWq9X1CSBZM1pBLlXEK3CdAVBHytd3NUGs/e1f8f38WcG9APHSOwBoWfbbdYw
 MCoLcq88gWzI9y0QqrzfD1mk4eSReeeNMjkE8lLrspuMnK98MAo/EDzsnibNASgh8yP8bZBet
 jGl1h48kk3FpNdxXRIPw2k5VJUVYwqufhxfN/FDmmBIkDr1e+86tUbYkzgwM/bugHdmoxRMvd
 z3H9sKIiiTaYcQjJ/7UVh8AmWJ+oCxeO3CKOoDYludUx9GfoC/SLjcbyAQuU484Y/+l4zjqxu
 lPB2pRIBAcszpBLoclJgqj9tlJaadp8IFfexSh1uRFNIq4VM721Gk9U8JJXdk5LrQRuORxM4f
 klyewf8KNgehoar+DCFTTlsi2isCnNLCcXIVIErDzg4BMC5DYEz6j1m9LxijIbKwfr2p2A4kS
 lx7/YDPOBQEyE70AW+eCO6r0iqZo/X9JJtBR4V23dJV6D7bU/loRCWGiUnjFEnt0SLdinN3LU
 zs7okgZxD7i/ABLIQ8yii5avdw8JqU2Cog/4GQh5OqwggYeabsoWJ44PaqPncUb6iu2F8RrxY
 yCO4tWYdAv+6DJHA9m4AuyDdTgTikkHWoHjgB0OE8+V7SWK7/USpk7k1c1Nmu02MJuBSDOvbZ
 /sUi736t2AvXRpbla
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> This is caused by dereferencing 'rpmb' after put_device().

I suggest to improve also this change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D051143e1602d90ea71887d9236=
3edd539d411de5#n151

How do you think about a wording variant like the following?

   The data structure member =E2=80=9Crpmb->md=E2=80=9D was passed to a ca=
ll of
   the function =E2=80=9Cmmc_blk_put=E2=80=9D after a call of the function=
 =E2=80=9Cput_device=E2=80=9D.
   Reorder these function calls to keep the data accesses consistent.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
