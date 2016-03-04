From: "Nowak, Mateusz" <mateusz.nowak@intel.com>
Subject: RE: [PATCH 0/2] mmc, block: override default max_dev_sectors
Date: Fri, 4 Mar 2016 10:49:29 +0000
Message-ID: <07856956733C274AB06C493240019A2D76CDEC35@IRSMSX101.ger.corp.intel.com>
References: <cover.1456847028.git.pawelx.wodkowski@intel.com>
 <20160302171227.GA5229@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5660 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbcCDKtp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2016 05:49:45 -0500
In-Reply-To: <20160302171227.GA5229@infradead.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, "Wodkowski, PawelX" <pawelx.wodkowski@intel.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Wednesday, March 2, 2016 18:12
> To: Wodkowski, PawelX <pawelx.wodkowski@intel.com>
> Cc: linux-block@vger.kernel.org; Nowak, Mateusz
> <mateusz.nowak@intel.com>; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH 0/2] mmc, block: override default max_dev_sectors
> 
> On Wed, Mar 02, 2016 at 09:54:15AM +0100, Pawel Wodkowski wrote:
> > From: Mateusz Nowak <mateusz.nowak@intel.com>
> >
> > commit ca369d51b3e1 ("block/sd: Fix device-imposed transfer length
> > limits") introduced max_dev_sectors as upper limit for max_hw_sectors.
> > This caused limitation of maximum block size to default
> > max_dev_sectors value - 127, causing performance degradation with
> higher block sizes.
> >
> > This patchset is allowing mmc driver to override max_dev_sectors value.
> 
> Past commit 5f009d ("block: Initialize max_dev_sectors to 0"), this should not
> be needed.

I missed the fix you mention while rebasing from rc3. Thus apologies for providing incorrectly described and not necessarily needed patch set.

However, since some drivers may still want to override max_dev_sectors, would the patches be good to be redone and resubmitted as improvement? If so, please let me know if there are any issues with them (apart from incorrect description), so their next version can be of improved quality.

Best regards,
Mateusz.
--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

