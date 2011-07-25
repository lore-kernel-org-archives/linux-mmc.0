From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH] mmc: mmc_test: avoid stalled file in debugfs
Date: Tue, 26 Jul 2011 00:15:59 +0200
Message-ID: <CAJ0pr19UbhitnopWFyh19ADErn9=VQ6Gxank-Ntc1_O4rGBb-g@mail.gmail.com>
References: <095a90240876c249ed33aa36f2543b54a0b68fc2.1311340371.git.andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45882 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab1GYWQB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2011 18:16:01 -0400
In-Reply-To: <095a90240876c249ed33aa36f2543b54a0b68fc2.1311340371.git.andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 22 July 2011 15:13, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> During card removal and inserting cycle the test file in the debugfs =
could be
> stalled until the host driver removes it. Let's keep the file in the =
linked
> list and destroy it when card is removed.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks for catching and fixing this mistake. The two debugfs files
test and testlist were created but only testlist was added to the
list. This patch takes care of that and adds both test and testlist to
the linked list, and makes the code cleaner too.


> ---
> =A0drivers/mmc/card/mmc_test.c | =A0 56 +++++++++++++++++++++++------=
--------------
> =A01 files changed, 30 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.=
c
> index 006a5e9..915a221 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -2900,7 +2900,7 @@ static const struct file_operations mmc_test_fo=
ps_testlist =3D {
> =A0 =A0 =A0 =A0.release =A0 =A0 =A0 =A0=3D single_release,
> =A0};
>
> -static void mmc_test_free_file_test(struct mmc_card *card)
> +static void mmc_test_free_dbgfs_file(struct mmc_card *card)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_test_dbgfs_file *df, *dfs;
>
> @@ -2917,34 +2917,21 @@ static void mmc_test_free_file_test(struct mm=
c_card *card)
> =A0 =A0 =A0 =A0mutex_unlock(&mmc_test_lock);
> =A0}
>
> -static int mmc_test_register_file_test(struct mmc_card *card)
> +static int __mmc_test_register_dbgfs_file(struct mmc_card *card,
> + =A0 =A0 =A0 const char *name, mode_t mode, const struct file_operat=
ions *fops)
> =A0{
> =A0 =A0 =A0 =A0struct dentry *file =3D NULL;
> =A0 =A0 =A0 =A0struct mmc_test_dbgfs_file *df;
> - =A0 =A0 =A0 int ret =3D 0;
> -
> - =A0 =A0 =A0 mutex_lock(&mmc_test_lock);
> -
> - =A0 =A0 =A0 if (card->debugfs_root)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 file =3D debugfs_create_file("test", S_=
IWUSR | S_IRUGO,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->debugfs_root, car=
d, &mmc_test_fops_test);
> -
> - =A0 =A0 =A0 if (IS_ERR_OR_NULL(file)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&card->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Can't create test. Per=
haps debugfs is disabled.\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> - =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (card->debugfs_root)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 file =3D debugfs_create_file("testlist"=
, S_IRUGO,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->debugfs_root, car=
d, &mmc_test_fops_testlist);
> +               file =3D debugfs_create_file(name, mode, card->debugf=
s_root,card,
> +                       fops);
Move card to next line together with fops and indent.
+               file =3D debugfs_create_file(name, mode, card->debugfs_=
root,
+                                                    card, fops);

>
> =A0 =A0 =A0 =A0if (IS_ERR_OR_NULL(file)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&card->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Can't create testlist.=
 Perhaps debugfs is disabled.\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Can't create %s. Perha=
ps debugfs is disabled.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0df =3D kmalloc(sizeof(struct mmc_test_dbgfs_file), GFP=
_KERNEL);
> @@ -2952,14 +2939,31 @@ static int mmc_test_register_file_test(struct=
 mmc_card *card)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0debugfs_remove(file);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&card->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Can't allocate memory=
 for internal usage.\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0df->card =3D card;
> =A0 =A0 =A0 =A0df->file =3D file;
>
> =A0 =A0 =A0 =A0list_add(&df->link, &mmc_test_file_test);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int mmc_test_register_dbgfs_file(struct mmc_card *card)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 mutex_lock(&mmc_test_lock);
> +
> + =A0 =A0 =A0 ret =3D __mmc_test_register_dbgfs_file(card, "test", S_=
IWUSR | S_IRUGO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 &mmc_test_fops_test);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> +
> + =A0 =A0 =A0 ret =3D __mmc_test_register_dbgfs_file(card, "testlist"=
, S_IRUGO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 &mmc_test_fops_testlist);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>
> =A0err:
> =A0 =A0 =A0 =A0mutex_unlock(&mmc_test_lock);
> @@ -2974,7 +2978,7 @@ static int mmc_test_probe(struct mmc_card *card=
)
> =A0 =A0 =A0 =A0if (!mmc_card_mmc(card) && !mmc_card_sd(card))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> - =A0 =A0 =A0 ret =3D mmc_test_register_file_test(card);
> + =A0 =A0 =A0 ret =3D mmc_test_register_dbgfs_file(card);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> @@ -2986,7 +2990,7 @@ static int mmc_test_probe(struct mmc_card *card=
)
> =A0static void mmc_test_remove(struct mmc_card *card)
> =A0{
> =A0 =A0 =A0 =A0mmc_test_free_result(card);
> - =A0 =A0 =A0 mmc_test_free_file_test(card);
> + =A0 =A0 =A0 mmc_test_free_dbgfs_file(card);
> =A0}
>
> =A0static struct mmc_driver mmc_driver =3D {
> @@ -3006,7 +3010,7 @@ static void __exit mmc_test_exit(void)
> =A0{
> =A0 =A0 =A0 =A0/* Clear stalled data if card is still plugged */
> =A0 =A0 =A0 =A0mmc_test_free_result(NULL);
> - =A0 =A0 =A0 mmc_test_free_file_test(NULL);
> + =A0 =A0 =A0 mmc_test_free_dbgfs_file(NULL);
>
> =A0 =A0 =A0 =A0mmc_unregister_driver(&mmc_driver);
> =A0}
> --
> 1.7.5.4
>
>

Acked-by: Per Forlin <per.forlin@linaro.org>

Thanks,
Per
