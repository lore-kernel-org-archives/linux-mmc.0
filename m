From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH v1 00/11] Add Qualcomm SD Card Controller support.
Date: Fri, 9 May 2014 10:56:35 -0700
Message-ID: <CAJAp7Oh2iZ2Tqv6cb6atpOfwrgKpHA5LtESLTt4gvVpXE0qDQA@mail.gmail.com>
References: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1398759492-12970-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1398759492-12970-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org, Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, agross@quicinc.com, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 29, 2014 at 1:18 AM,  <srinivas.kandagatla@linaro.org> wrote:
[...]
> This patch series adds Qualcomm SD Card Controller support in pl180 mmci
> driver. QCom SDCC is basically a pl180, but bit more customized, some of the
> register layouts and offsets are different to the ones mentioned in pl180
> datasheet. The plan is to totally remove the standalone SDCC driver
> drivers/mmc/host/msm_sdcc.* and start using generic mmci driver for all
> Qualcomm parts, as we get chance to test on other Qcom boards.

Hi Srinivas,

I think your series looks good, so I pulled it into my tree and
combined with some input from [1] I got this up and running on Sony
Xperia T (msm8960 based).

I do get below prints in dmesg during probe, mount and some initial
accesses; but the code seems to retry the operations and things work
out nicely.

[  193.556540] mmcblk0: response CRC error sending r/w cmd command,
card status 0xb00


PS. please send the patch enabling AMBA to Kumar as well.

[1] https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/commitdiff/14ea2f1dc5bb719dbfb943e2c700ac166a8c125a

Regards,
Bjorn
