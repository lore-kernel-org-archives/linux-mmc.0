From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 02/12] mmc: mmc_test: add debugfs file to list all tests
Date: Sun, 8 May 2011 01:18:36 +0300
Message-ID: <BANLkTim2k_hb0Bw_cYeTUv-dMzyWVPO+gA@mail.gmail.com>
References: <1304795706-27308-1-git-send-email-per.forlin@linaro.org>
	<1304795706-27308-3-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304795706-27308-3-git-send-email-per.forlin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, May 7, 2011 at 10:14 PM, Per Forlin <per.forlin@linaro.org> wro=
te:
> Add a debugfs file "testlist" to print all available tests
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> =C2=A0drivers/mmc/card/mmc_test.c | =C2=A0 30 +++++++++++++++++++++++=
+++++++
> =C2=A01 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.=
c
> index abc1a63..c1c3c5a 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c


> @@ -2476,6 +2502,10 @@ static int mmc_test_register_file_test(struct =
mmc_card *card)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file =3D debug=
fs_create_file("test", S_IWUSR | S_IRUGO,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0card->debugfs_root, card, &mmc_test_fops_test);
>
> + =C2=A0 =C2=A0 =C2=A0 if (card->debugfs_root)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file =3D debugfs_c=
reate_file("testlist", S_IRUGO,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 card->debugfs_root, card, &mmc_test_fops_testlist);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR_OR_NULL(file)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&card-=
>dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"Can't create file. Perhaps debugfs is disabled.\n");
I think you also need to use similar error path for both files: test
and testlist.


--=20
With Best Regards,
Andy Shevchenko
