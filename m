From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH 04/27] mmc: cb710: Move away from using deprecated APIs
Date: Fri, 27 Sep 2013 18:08:51 +0200
Message-ID: <20130927160851.GA14940@rere.qmqm.pl>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
 <1380207292-16968-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:37129 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458Ab3I0QRI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Sep 2013 12:17:08 -0400
Content-Disposition: inline
In-Reply-To: <1380207292-16968-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Thu, Sep 26, 2013 at 04:54:29PM +0200, Ulf Hansson wrote:
> Suspend and resume of cards are being handled from the protocol layer
> and consequently the mmc_suspend|resume_host APIs are deprecated.
>=20
> This means we can simplify the suspend|resume callbacks by removing t=
he
> use of the deprecated APIs.
>=20
> Cc: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch looks consistent with commit message. I can't test it on HW, thou=
gh.

Acked-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
