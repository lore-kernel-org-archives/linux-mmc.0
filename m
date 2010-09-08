From: hong zhang <henryzhang62@yahoo.com>
Subject: Re: [PATCHv6 3/3] mmc_test: collect data and show it via sysfs by demand
Date: Wed, 8 Sep 2010 07:44:44 -0700 (PDT)
Message-ID: <877713.29364.qm@web57908.mail.re3.yahoo.com>
References: <d7cf4d98c6e0396da903c2e49b028f240853bfc2.1283862780.git.ext-andriy.shevchenko@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from web57908.mail.re3.yahoo.com ([68.142.236.101]:41519 "HELO
	web57908.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751639Ab0IHOoq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Sep 2010 10:44:46 -0400
In-Reply-To: <d7cf4d98c6e0396da903c2e49b028f240853bfc2.1283862780.git.ext-andriy.shevchenko@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hunter Adrian <adrian.hunter@nokia.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Andy,

Would you please give any command to check card type?

---henry

--- On Tue, 9/7/10, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> Subject: [PATCHv6 3/3] mmc_test: collect data and show it via sysfs b=
y demand
> To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
> Cc: "Hunter Adrian" <adrian.hunter@nokia.com>, "Chris Ball" <cjb@lapt=
op.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Andy Shevchenko"=
 <ext-andriy.shevchenko@nokia.com>
> Date: Tuesday, September 7, 2010, 7:35 AM
> TODO:
>  - implement show() method based on seq_file API
>=20
> Changes since v5:
>  - we can't use BUG_ON at exit() method because it quite
> normal case when the
> =A0=A0=A0module is going to be removed with card
> plugged in, that's why we just free
> =A0=A0=A0memory there
>  - rebase against recent linux-next tree
>=20
> Changes since v4:
>  - BUG_ON at exit if the list of the results isn't empty
>=20
> Changes since v3:
>  - fix multi-line commentary style
>  - protect mmc_test_free_result() by mutex
>  - apply known values to newly created
> mmc_test_general_result structure before
> =A0=A0=A0attaching it to the list
>  - call list_del() before free mmc_test_transfer_result
> structure
>  - check truncated output in show() method, return -ENOBUFS
> if so
>  - avoid deadlock in show() method if snprintf() fails
>=20
> Changes since v2:
>  - move card memeber to mmc_test_general_result structrure
> and thus throw away
> =A0=A0=A0mmc_test_overall_result which was
> overkill
>  - check result of kmalloc and kzalloc
>  - keep pointer to the actual mmc_test_general_result
> structure in the
> =A0=A0=A0mmc_test_card
>=20
> Changes since v1:
>  - structrure members are described
>  - save transfer results code is split to separate
> function
>  - in mmc_test_print_rate() use count =3D 1 instead of 0
>  - mmc_test_result keeps overall results (across all tested
> cards), however
> =A0=A0=A0it's still global variable
>  - list_head variables inside structures have a suffix _lst
> now
>=20
> Here is a patch which brings possibility to get test
> results via sysfs. It
> helps to do tests non-interactively.
>=20
> We have the file created under sysfs already and we could
> use it to out test
> results.
>=20
> This patch applied on top of patches published here [1]
>=20
> [1] http://lkml.org/lkml/2010/8/18/164
>=20
> Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
> ---
>  drivers/mmc/card/mmc_test.c |=A0 171
> ++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 169 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/card/mmc_test.c
> b/drivers/mmc/card/mmc_test.c
> index 6bffb33..58d746b 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -17,6 +17,7 @@
> =20
>  #include <linux/scatterlist.h>
>  #include <linux/swap.h>=A0=A0=A0
> =A0=A0=A0 /* For nr_free_buffer_pages() */
> +#include <linux/list.h>
> =20
>  #define RESULT_OK=A0=A0=A0 =A0=A0=A0 0
>  #define RESULT_FAIL=A0=A0=A0 =A0=A0=A0
> 1
> @@ -73,12 +74,45 @@ struct mmc_test_area {
>  };
> =20
>  /**
> + * struct mmc_test_transfer_result - transfer results for
> performance tests.
> + * @link: double-linked list
> + * @count: amount of group of sectors to check
> + * @sectors: amount of sectors to check in one group
> + * @ts: time values of transfer
> + * @rate: calculated transfer rate
> + */
> +struct mmc_test_transfer_result {
> +=A0=A0=A0 struct list_head link;
> +=A0=A0=A0 unsigned int count;
> +=A0=A0=A0 unsigned int sectors;
> +=A0=A0=A0 struct timespec ts;
> +=A0=A0=A0 unsigned int rate;
> +};
> +
> +/**
> + * struct mmc_test_general_result - results for tests.
> + * @link: double-linked list
> + * @card: card under test
> + * @testcase: number of test case
> + * @result: result of test run
> + * @tr_lst: transfer measurements if any as
> mmc_test_transfer_result
> + */
> +struct mmc_test_general_result {
> +=A0=A0=A0 struct list_head link;
> +=A0=A0=A0 struct mmc_card *card;
> +=A0=A0=A0 int testcase;
> +=A0=A0=A0 int result;
> +=A0=A0=A0 struct list_head tr_lst;
> +};
> +
> +/**
> =A0 * struct mmc_test_card - test information.
> =A0 * @card: card under test
> =A0 * @scratch: transfer buffer
> =A0 * @buffer: transfer buffer
> =A0 * @highmem: buffer for highmem tests
> =A0 * @area: information for performance tests
> + * @gr: pointer to results of current testcase
> =A0 */
>  struct mmc_test_card {
>  =A0=A0=A0 struct mmc_card=A0=A0=A0
> *card;
> @@ -88,7 +122,8 @@ struct mmc_test_card {
>  #ifdef CONFIG_HIGHMEM
>  =A0=A0=A0 struct page=A0=A0=A0
> *highmem;
>  #endif
> -=A0=A0=A0 struct mmc_test_area area;
> +=A0=A0=A0 struct mmc_test_area=A0=A0=A0
> =A0=A0=A0 area;
> +=A0=A0=A0 struct
> mmc_test_general_result=A0=A0=A0 *gr;
>  };
> =20
>=20
> /*******************************************************************/
> @@ -421,6 +456,30 @@ static unsigned int
> mmc_test_rate(uint64_t bytes, struct timespec *ts)
>  }
> =20
>  /*
> + * Save transfer results for future usage
> + */
> +static void mmc_test_save_transfer_result(struct
> mmc_test_card *test,
> +=A0=A0=A0 unsigned int count, unsigned int
> sectors, struct timespec ts,
> +=A0=A0=A0 unsigned int rate)
> +{
> +=A0=A0=A0 struct mmc_test_transfer_result *tr;
> +
> +=A0=A0=A0 if (!test->gr)
> +=A0=A0=A0 =A0=A0=A0 return;
> +
> +=A0=A0=A0 tr =3D kmalloc(sizeof(struct
> mmc_test_transfer_result), GFP_KERNEL);
> +=A0=A0=A0 if (!tr)
> +=A0=A0=A0 =A0=A0=A0 return;
> +
> +=A0=A0=A0 tr->count =3D count;
> +=A0=A0=A0 tr->sectors =3D sectors;
> +=A0=A0=A0 tr->ts =3D ts;
> +=A0=A0=A0 tr->rate =3D rate;
> +
> +=A0=A0=A0 list_add_tail(&tr->link,
> &test->gr->tr_lst);
> +}
> +
> +/*
> =A0 * Print the transfer rate.
> =A0 */
>  static void mmc_test_print_rate(struct mmc_test_card
> *test, uint64_t bytes,
> @@ -438,6 +497,8 @@ static void mmc_test_print_rate(struct
> mmc_test_card *test, uint64_t bytes,
>  =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0=A0=A0mmc_hostname(test->card->host),
> sectors, sectors >> 1,
>  =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0=A0=A0(sectors =3D=3D 1 ? ".5" : ""),
> (unsigned long)ts.tv_sec,
>  =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0=A0=A0(unsigned long)ts.tv_nsec,
> rate / 1000, rate / 1024);
> +
> +=A0=A0=A0 mmc_test_save_transfer_result(test, 1,
> sectors, ts, rate);
>  }
> =20
>  /*
> @@ -461,6 +522,8 @@ static void
> mmc_test_print_avg_rate(struct mmc_test_card *test, uint64_t
> bytes,
>  =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0=A0=A0sectors >> 1, (sectors
> =3D=3D 1 ? ".5" : ""),
>  =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0=A0=A0(unsigned long)ts.tv_sec,
> (unsigned long)ts.tv_nsec,
>  =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0=A0=A0rate / 1000, rate / 1024);
> +
> +=A0=A0=A0 mmc_test_save_transfer_result(test,
> count, sectors, ts, rate);
>  }
> =20
>  /*
> @@ -1853,6 +1916,8 @@ static const struct mmc_test_case
> mmc_test_cases[] =3D {
> =20
>  static DEFINE_MUTEX(mmc_test_lock);
> =20
> +static LIST_HEAD(mmc_test_result);
> +
>  static void mmc_test_run(struct mmc_test_card *test, int
> testcase)
>  {
>  =A0=A0=A0 int i, ret;
> @@ -1863,6 +1928,8 @@ static void mmc_test_run(struct
> mmc_test_card *test, int testcase)
>  =A0=A0=A0
> mmc_claim_host(test->card->host);
> =20
>  =A0=A0=A0 for (i =3D 0;i <
> ARRAY_SIZE(mmc_test_cases);i++) {
> +=A0=A0=A0 =A0=A0=A0 struct
> mmc_test_general_result *gr;
> +
>  =A0=A0=A0 =A0=A0=A0 if (testcase
> && ((i + 1) !=3D testcase))
>  =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> continue;
> =20
> @@ -1881,6 +1948,25 @@ static void mmc_test_run(struct
> mmc_test_card *test, int testcase)
>  =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> }
>  =A0=A0=A0 =A0=A0=A0 }
> =20
> +=A0=A0=A0 =A0=A0=A0 gr =3D
> kzalloc(sizeof(struct mmc_test_general_result),
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> GFP_KERNEL);
> +=A0=A0=A0 =A0=A0=A0 if (gr) {
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> INIT_LIST_HEAD(&gr->tr_lst);
> +
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> /* Assign data what we know already */
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> gr->card =3D test->card;
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> gr->testcase =3D i;
> +
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> /* Append container to global one */
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> list_add_tail(&gr->link, &mmc_test_result);
> +
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> /*
> +=A0=A0=A0 =A0=A0=A0
> =A0=A0=A0=A0=A0* Save the pointer to created
> container in our private
> +=A0=A0=A0 =A0=A0=A0
> =A0=A0=A0=A0=A0* structure.
> +=A0=A0=A0 =A0=A0=A0
> =A0=A0=A0=A0=A0*/
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> test->gr =3D gr;
> +=A0=A0=A0 =A0=A0=A0 }
> +
>  =A0=A0=A0 =A0=A0=A0 ret =3D
> mmc_test_cases[i].run(test);
>  =A0=A0=A0 =A0=A0=A0 switch (ret) {
>  =A0=A0=A0 =A0=A0=A0 case RESULT_OK:
> @@ -1906,6 +1992,10 @@ static void mmc_test_run(struct
> mmc_test_card *test, int testcase)
>  =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0 mmc_hostname(test->card->host),
> ret);
>  =A0=A0=A0 =A0=A0=A0 }
> =20
> +=A0=A0=A0 =A0=A0=A0 /* Save the result
> */
> +=A0=A0=A0 =A0=A0=A0 if (gr)
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> gr->result =3D ret;
> +
>  =A0=A0=A0 =A0=A0=A0 if
> (mmc_test_cases[i].cleanup) {
>  =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> ret =3D mmc_test_cases[i].cleanup(test);
>  =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> if (ret) {
> @@ -1923,13 +2013,80 @@ static void mmc_test_run(struct
> mmc_test_card *test, int testcase)
>  =A0=A0=A0 =A0=A0=A0
> mmc_hostname(test->card->host));
>  }
> =20
> +static void mmc_test_free_result(struct mmc_card *card)
> +{
> +=A0=A0=A0 struct mmc_test_general_result *gr,
> *grs;
> +
> +=A0=A0=A0 mutex_lock(&mmc_test_lock);
> +
> +=A0=A0=A0 list_for_each_entry_safe(gr, grs,
> &mmc_test_result, link) {
> +=A0=A0=A0 =A0=A0=A0 struct
> mmc_test_transfer_result *tr, *trs;
> +
> +=A0=A0=A0 =A0=A0=A0 if (card &&
> gr->card !=3D card)
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> continue;
> +
> +=A0=A0=A0 =A0=A0=A0
> list_for_each_entry_safe(tr, trs, &gr->tr_lst, link)
> {
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> list_del(&tr->link);
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> kfree(tr);
> +=A0=A0=A0 =A0=A0=A0 }
> +
> +=A0=A0=A0 =A0=A0=A0
> list_del(&gr->link);
> +=A0=A0=A0 =A0=A0=A0 kfree(gr);
> +=A0=A0=A0 }
> +
> +=A0=A0=A0 mutex_unlock(&mmc_test_lock);
> +}
> +
>  static ssize_t mmc_test_show(struct device *dev,
>  =A0=A0=A0 struct device_attribute *attr, char
> *buf)
>  {
> +=A0=A0=A0 struct mmc_card *card =3D
> mmc_dev_to_card(dev);
> +=A0=A0=A0 struct mmc_test_general_result *gr;
> +=A0=A0=A0 char *p =3D buf;
> +=A0=A0=A0 size_t len =3D PAGE_SIZE;
> +=A0=A0=A0 int ret;
> +
>  =A0=A0=A0 mutex_lock(&mmc_test_lock);
> +
> +=A0=A0=A0 list_for_each_entry(gr,
> &mmc_test_result, link) {
> +=A0=A0=A0 =A0=A0=A0 struct
> mmc_test_transfer_result *tr;
> +
> +=A0=A0=A0 =A0=A0=A0 if (gr->card !=3D
> card)
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> continue;
> +
> +=A0=A0=A0 =A0=A0=A0 ret =3D snprintf(p,
> len, "Test %d: %d\n", gr->testcase + 1,
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> gr->result);
> +=A0=A0=A0 =A0=A0=A0 if (ret < 0)
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> goto err;
> +=A0=A0=A0 =A0=A0=A0 if (ret >=3D len)
> {
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> ret =3D -ENOBUFS;
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> goto err;
> +=A0=A0=A0 =A0=A0=A0 }
> +=A0=A0=A0 =A0=A0=A0 p +=3D ret;
> +=A0=A0=A0 =A0=A0=A0 len -=3D ret;
> +
> +=A0=A0=A0 =A0=A0=A0
> list_for_each_entry(tr, &gr->tr_lst, link) {
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> ret =3D snprintf(p, len, "%u %d %lu.%09lu %u\n",
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0 tr->count, tr->sectors,
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0 (unsigned long)tr->ts.tv_sec,
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0 (unsigned long)tr->ts.tv_nsec,
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0 tr->rate);
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> if (ret < 0)
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0 goto err;
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> if (ret >=3D len) {
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0 ret =3D -ENOBUFS;
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0 goto err;
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> }
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 p
> +=3D ret;
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> len -=3D ret;
> +=A0=A0=A0 =A0=A0=A0 }
> +=A0=A0=A0 }
> +
> +=A0=A0=A0 ret =3D PAGE_SIZE - len;
> +err:
>  =A0=A0=A0 mutex_unlock(&mmc_test_lock);
> =20
> -=A0=A0=A0 return 0;
> +=A0=A0=A0 return ret;
>  }
> =20
>  static ssize_t mmc_test_store(struct device *dev,
> @@ -1946,6 +2103,12 @@ static ssize_t mmc_test_store(struct
> device *dev,
>  =A0=A0=A0 if (!test)
>  =A0=A0=A0 =A0=A0=A0 return -ENOMEM;
> =20
> +=A0=A0=A0 /*
> +=A0=A0=A0=A0=A0* Remove all test cases
> associated with given card. Thus we have only
> +=A0=A0=A0=A0=A0* actual data of the last
> run.
> +=A0=A0=A0=A0=A0*/
> +=A0=A0=A0 mmc_test_free_result(card);
> +
>  =A0=A0=A0 test->card =3D card;
> =20
>  =A0=A0=A0 test->buffer =3D kzalloc(BUFFER_SIZE,
> GFP_KERNEL);
> @@ -1992,6 +2155,7 @@ static int mmc_test_probe(struct
> mmc_card *card)
> =20
>  static void mmc_test_remove(struct mmc_card *card)
>  {
> +=A0=A0=A0 mmc_test_free_result(card);
>  =A0=A0=A0 device_remove_file(&card->dev,
> &dev_attr_test);
>  }
> =20
> @@ -2010,6 +2174,9 @@ static int __init
> mmc_test_init(void)
> =20
>  static void __exit mmc_test_exit(void)
>  {
> +=A0=A0=A0 /* Clear stalled data if card is still
> plugged */
> +=A0=A0=A0 mmc_test_free_result(NULL);
> +
>  =A0=A0=A0
> mmc_unregister_driver(&mmc_driver);
>  }
> =20
> --=20
> 1.6.3.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20


     =20
