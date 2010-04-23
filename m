From: Anton Vorontsov <avorontsov@mvista.com>
Subject: [PATCH] sdhci-pltfm: Add kernel-doc for struct sdhci_pltfm_data
Date: Fri, 23 Apr 2010 22:26:19 +0400
Message-ID: <20100423182619.GA8743@oksana.dev.rtsoft.ru>
References: <20100316183400.GA24191@oksana.dev.rtsoft.ru>
 <20100316183429.GB25670@oksana.dev.rtsoft.ru>
 <4BA0732B.7040007@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imap.ru.mvista.com ([213.79.90.228]:54380 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751236Ab0DWSvS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Apr 2010 14:51:18 -0400
Content-Disposition: inline
In-Reply-To: <4BA0732B.7040007@pelagicore.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors@pelagicore.com>
Cc: David Vrabel <david.vrabel@csr.com>, Pierre Ossman <pierre@ossman.eu>, Ben Dooks <ben@simtec.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org


Suggested-by: Richard R=C3=B6jfors <richard.rojfors@pelagicore.com>
Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---

On Wed, Mar 17, 2010 at 07:14:03AM +0100, Richard R=C3=B6jfors wrote:
> On 3/16/10 7:34 PM, Anton Vorontsov wrote:
> > This includes platform ops, quirks and (de)initialization callbacks=
=2E
>=20
> Good idea, just a doc comment below.
[....]
> > +struct sdhci_pltfm_data {
> > +	struct sdhci_ops *ops;
> > +	unsigned int quirks;
> > +	int (*init)(struct sdhci_host *host);
> > +	void (*exit)(struct sdhci_host *host);
> > +};
>=20
> I would like to see this struct kernel-doc:ed.

Done, thanks!

Andrew,

Please fold this patch into
sdhci-pltfm-implement-platform-data-passing.patch

Thanks,

 include/linux/sdhci-pltfm.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm.h
index 0aaa334..0239bd7 100644
--- a/include/linux/sdhci-pltfm.h
+++ b/include/linux/sdhci-pltfm.h
@@ -17,6 +17,14 @@
 struct sdhci_ops;
 struct sdhci_host;
=20
+/**
+ * struct sdhci_pltfm_data - SDHCI platform-specific information & hoo=
ks
+ * @ops: optional pointer to the platform-provided SDHCI ops
+ * @quirks: optional SDHCI quirks
+ * @init: optional hook that is called during device probe, before the
+ *        driver tries to access any SDHCI registers
+ * @exit: optional hook that is called during device removal
+ */
 struct sdhci_pltfm_data {
 	struct sdhci_ops *ops;
 	unsigned int quirks;
--=20
1.7.0.5

