From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] mmc: host: tighten some of the dependencies on SoC
 drivers
Date: Wed, 24 May 2017 16:47:04 +0200
Message-ID: <2ea26581-ec72-cfb4-dc0d-df20562c36d3@i2se.com>
References: <20170524121556.27819-1-pbrobinson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:54678 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933703AbdEXOrN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2017 10:47:13 -0400
In-Reply-To: <20170524121556.27819-1-pbrobinson@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org

Hi Peter,

Am 24.05.2017 um 14:15 schrieb Peter Robinson:
> Cleanup and tighten some of the dependencies for SoC specific hardware, remove a
> duplication on MMC_SDHI, and add COMPILE_TEST where we add SoC specifics to
> ensure continued build coverage.

i suggest to send a copy to the relevant driver / platform maintainers.

Stefan

