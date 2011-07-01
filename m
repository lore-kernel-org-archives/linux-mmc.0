From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v8 05/12] mmc: mmc_test: add test for non-blocking transfers
Date: Fri, 1 Jul 2011 15:29:25 +0200
Message-ID: <BANLkTi=-Nn0HjLgmTsCs9zoQt4By-6-KZw@mail.gmail.com>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
	<1309248717-14606-6-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58603 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756499Ab1GAN30 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2011 09:29:26 -0400
In-Reply-To: <1309248717-14606-6-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Nickolay
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>

On 28 June 2011 10:11, Per Forlin <per.forlin@linaro.org> wrote:
> Add four tests for read and write performance per
> different transfer size, 4k to 4M.
> =A0* Read using blocking mmc request
> =A0* Read using non-blocking mmc request
> =A0* Write using blocking mmc request
> =A0* Write using non-blocking mmc request
>
> The host dirver must support pre_req() and post_req()
> in order to run the non-blocking test cases.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> =A0drivers/mmc/card/mmc_test.c | =A0311 +++++++++++++++++++++++++++++=
++++++++++++-
> =A01 files changed, 303 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.=
c
> +static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct scatterlist *sg, unsigned sg_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 unsigned dev_addr, unsigned blocks,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 unsigned blksz, int write, int count)
> +{
> + =A0 =A0 =A0 struct mmc_request mrq1;
> + =A0 =A0 =A0 struct mmc_command cmd1;
> + =A0 =A0 =A0 struct mmc_command stop1;
> + =A0 =A0 =A0 struct mmc_data data1;
> +
> + =A0 =A0 =A0 struct mmc_request mrq2;
> + =A0 =A0 =A0 struct mmc_command cmd2;
> + =A0 =A0 =A0 struct mmc_command stop2;
> + =A0 =A0 =A0 struct mmc_data data2;
> +
> + =A0 =A0 =A0 struct mmc_test_async_req test_areq[2];
> + =A0 =A0 =A0 struct mmc_async_req *done_areq;
> + =A0 =A0 =A0 struct mmc_async_req *cur_areq =3D &test_areq[0].areq;
> + =A0 =A0 =A0 struct mmc_async_req *other_areq =3D &test_areq[1].areq=
;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 test_areq[0].test =3D test;
> + =A0 =A0 =A0 test_areq[1].test =3D test;
> +
> + =A0 =A0 =A0 if (!test->card->host->ops->pre_req ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 !test->card->host->ops->post_req)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -RESULT_UNSUP_HOST;
Remove this error check. It is fine to run this test without these
hooks, but there will be no performance gain compared to blocking
request.

=2E..

> +/*
> + * Multiple blocking write 4k to 4 MB chunks
> + */
> +static int mmc_test_profile_mult_write_blocking_perf(struct mmc_test=
_card *test)
> +{
> + =A0 =A0 =A0 unsigned int bs[] =3D {1 << 12, 1 << 13, 1 << 14, 1 << =
15, 1 << 16,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01 << 17, 1 <=
< 18, 1 << 19, 1 << 20, 1 << 22};
> + =A0 =A0 =A0 struct mmc_test_multiple_rw test_data =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bs =3D bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =3D 128*1024*1024,
I got this comment from Linus W.
Use TEST_AREA_MAX_SIZE instead of hard coded 128*1024*1024. update all
relevant functions.

/Per
