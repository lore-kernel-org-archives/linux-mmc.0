From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH 1/2] regulator: add regulator_is_dummy function
Date: Mon, 7 Jan 2013 06:36:36 -0500
Message-ID: <CADz5_gJvtgwA9c88wZcjQArmKiAtB7CLHvRAxkDNUnNpM8Z8Qg@mail.gmail.com>
References: <1357537131-8000-1-git-send-email-kliu5@marvell.com>
	<20130107112527.GD4544@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20130107112527.GD4544@opensource.wolfsonmicro.com>
Sender: linux-pm-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kevin Liu <kliu5@marvell.com>, linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Rainer Kaluscha <rainer.kaluscha@web.de>, Rainer Kaluscha <ich@rainer-kaluscha.de>, Philip Rakity <prakity@nvidia.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: linux-mmc@vger.kernel.org

2013/1/7 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Jan 07, 2013 at 01:38:50PM +0800, Kevin Liu wrote:
>> Introduce a regulator_is_dummy function to check whether the
>> regulator is dummy.
>
> No, we've been through this repeatedly.  Whatever problem you're trying
> to bodge around is going to be a problem with some real physical
> regulators too.

Then the only way is MUST define the regulator rather than let dummy
regulator handle it, right?
