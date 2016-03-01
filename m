From: Shawn Lin <shawn.lin@kernel-upstream.org>
Subject: Re: MMC broken in kernel 4.4
Date: Tue, 1 Mar 2016 18:11:06 +0800
Message-ID: <56D56ABA.5020206@kernel-upstream.org>
References: <hubert_tonneau/BJJ9BVJR/0G321OJ19@hubert-tonneau.storga.com>
 <56D44249.7070200@kernel-upstream.org>
 <hubert_tonneau/727MOBXX/0G32U5D@hubert-tonneau.storga.com>
 <56D4FCC2.1020604@kernel-upstream.org>
 <hubert_tonneau/RM1SK4J9/0G33XJU@hubert-tonneau.storga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mr213138.mail.yeah.net ([223.252.213.138]:36778 "EHLO
	mr213138.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbcCAKLg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2016 05:11:36 -0500
In-Reply-To: <hubert_tonneau/RM1SK4J9/0G33XJU@hubert-tonneau.storga.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Barry Song <Baohua.Song@csr.com>

Thanks for testing and plus Barry.

So Ulf, I can't remember we have a fix into 4.4#[-rc*] for it, right?
How about take this changes into more consideration?

 From the changelog, it's modified for SD 3.01 which makes bus test
a mandatory requirement. But how mmc stack know its version is  3.0 or 3.1 ?

On 2016-3-1 17:46, Hubert Tonneau wrote:
>
> Hi,
>
> With the patch reversed, 4.4.X kernel works on Lenovo Yoga 8 tablet, 
> just like kernel 4.3.X
>
> Shawn Lin wrote:
> >
> > Do you have this part of code[0] in your repository?
> >
> > [0]: https://patchwork.kernel.org/patch/7323541/
>
> Regards,
> Hubert Tonneau
>

