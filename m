From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH v3 1/2] mmc: tegra: disable UHS modes
Date: Fri, 23 May 2014 13:52:42 +0100
Message-ID: <86fvk0r71h.fsf@void.printf.net>
References: <1400774136-12396-1-git-send-email-abrestic@chromium.org>
 <CAPDyKFpt98rbFpvu1uzbOuhCTrO96hzQU2VwNRgJGfoi_7F-OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpt98rbFpvu1uzbOuhCTrO96hzQU2VwNRgJGfoi_7F-OA@mail.gmail.com>
 (Ulf Hansson's message of "Fri, 23 May 2014 09:03:33 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Andrew Bresticker <abrestic@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, May 23 2014, Ulf Hansson wrote:
> On 22 May 2014 17:55, Andrew Bresticker <abrestic@chromium.org> wrote:
>> Program TEGRA_SDHCI_VENDOR_MISC_CTRL so that UHS modes aren't advertised
>> in SDHCI_CAPABILITIES_1.  While the Tegra SDHCI controller does support
>> these modes, they require Tegra-specific tuning and calibration routines
>> which the driver does not support yet.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Tested-by: Stephen Warren <swarren@nvidia.com>
>> Acked-by: Stephen Warren <swarren@nvidia.com>
>
> Thanks Andrew!
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Chris, can you pick this up?

Thanks, pushed to mmc-next for 3.16.

- Chris.
-- 
Chris Ball   <http://printf.net/>
