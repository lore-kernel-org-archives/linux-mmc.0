From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Add device tree support
Date: Thu, 16 Aug 2012 21:27:40 +0530
Message-ID: <CAJuYYwQjN9UtXcfjNXf1Ezw3igfUSQDNEP8X038L4=br6EROUA@mail.gmail.com>
References: <1345132169-21066-1-git-send-email-thomas.abraham@linaro.org>
	<87obmadeko.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <87obmadeko.fsf@octavius.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

Thanks for your review.

On 16 August 2012 21:17, Chris Ball <cjb@laptop.org> wrote:
> Hi Thomas,
>
> On Thu, Aug 16 2012, Thomas Abraham wrote:
>> Add device tree based discovery support for Samsung's sdhci controller
>>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Chris Ball <cjb@laptop.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci-s3c.c |  146 ++++++++++++++++++++++++++++++++++++++++--
>>  1 files changed, 140 insertions(+), 6 deletions(-)
>
> I know your initial version was submitted before we adopted a set of
> standard MMC DT bindings, but now that those bindings exist this code
> should be using them -- there should be a new file:
>    Documentation/devicetree/bindings/mmc/sdhci-s3c.txt
> describing differences between the mmc.txt bindings and this driver's.

Sorry, I missed that. I will resend this patch with the documentation.

>
> Also, you didn't include a patch changelog, so I can't tell whether this
> contains changes against your v3 of this patch; please do that.

Yes, I missed the changelog as well. I will add it in the next version
of this patch.

Thanks,
Thomas.

>
> Thanks!
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
