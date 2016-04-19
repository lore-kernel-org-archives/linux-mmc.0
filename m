From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] mmc: core: Improve marking broken HPI through
 devicetree
Date: Tue, 19 Apr 2016 13:52:54 +0300
Message-ID: <57160E06.1000806@cogentembedded.com>
References: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
 <1461049934-12848-2-git-send-email-oliver@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35773 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbcDSKw7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 06:52:59 -0400
Received: by mail-lf0-f50.google.com with SMTP id c126so14006778lfb.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2016 03:52:58 -0700 (PDT)
In-Reply-To: <1461049934-12848-2-git-send-email-oliver@schinagl.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Michal Hocko <mhocko@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wenkai Du <wenkai.du@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Hans de Goede <hdegoede@redhat.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Suchanek <hramrach@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello.

On 4/19/2016 10:12 AM, Olliver Schinagl wrote:

> In patch 81f8a7be66 Hans de Goede added a patch to allow marking an mmc

    scripts/checkpatch.pl now enforces certain commit citing style, the commit 
summary should be specified too.

> device as to having an broken HPI implementation. After talking some
> with Hans, we now think it is actually the mmc controller that can be
> broken and not support broken HPI's.
>
> This patch adds a new capability, mmc-broken-hpi, which allows us to
> mark a broken hpi implementation on the host level.
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
[...]

MBR, Sergei

