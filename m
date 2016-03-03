From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Subject: Re: MMC broken in kernel 4.4
Date: Thu, 3 Mar 2016 10:29:48 +0000
Message-ID: <hubert_tonneau/RM1SK4J9/0G37PAN@hubert-tonneau.storga.com>
References: <hubert_tonneau/BJJ9BVJR/0G321OJ19@hubert-tonneau.storga.com> <56D44249.7070200@kernel-upstream.org> <hubert_tonneau/727MOBXX/0G32U5D@hubert-tonneau.storga.com> <56D4FCC2.1020604@kernel-upstream.org> <hubert_tonneau/RM1SK4J9/0G33XJU@hubert-tonneau.storga.com> <56D56ABA.5020206@kernel-upstream.org> <56D6D4AC.40205@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dc1.fullpliant.org ([213.186.44.166]:44222 "HELO
	storga1.copliant.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753924AbcCCKiy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2016 05:38:54 -0500
In-Reply-To: <56D6D4AC.40205@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Shawn Lin <shawn.lin@kernel-upstream.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Barry Song <Baohua.Song@csr.com>

Adrian Hunter wrote:
>
> It might also be related to the problem here:
> 
> 	http://marc.info/?l=linux-mmc&m=145319732219412
> 
> You might try keeping the patch and applying the two referred to above.

Hi,

Stock kernel 4.4.3 with the two extra patches does not work.

Regards,
Hubert Tonneau
