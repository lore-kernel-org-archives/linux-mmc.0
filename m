From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: mmc_test: Remove set-but-unused variable.
Date: Wed, 16 Mar 2011 17:52:34 -0400
Message-ID: <1300312354-4144-1-git-send-email-cjb@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:49553 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab1CPVzo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2011 17:55:44 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>

=46ixes:

drivers/mmc/card/mmc_test.c: In function =E2=80=98mmc_test_seq_perf=E2=80=
=99:
drivers/mmc/card/mmc_test.c:1878:28: warning: variable =E2=80=98ts=E2=80=
=99 set but not
used [-Wunused-but-set-variable]

There's no reason to be calling timespec_sub() here, because
mmc_test_print_avg_rate() is going to do that itself.

Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/card/mmc_test.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 5ec8edd..f5cedec 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -1875,7 +1875,7 @@ static int mmc_test_seq_perf(struct mmc_test_card=
 *test, int write,
 			     unsigned int tot_sz, int max_scatter)
 {
 	unsigned int dev_addr, i, cnt, sz, ssz;
-	struct timespec ts1, ts2, ts;
+	struct timespec ts1, ts2;
 	int ret;
=20
 	sz =3D test->area.max_tfr;
@@ -1912,7 +1912,6 @@ static int mmc_test_seq_perf(struct mmc_test_card=
 *test, int write,
 	}
 	getnstimeofday(&ts2);
=20
-	ts =3D timespec_sub(ts2, ts1);
 	mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
=20
 	return 0;
--=20
1.7.0.1

