From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH V6] SDHCI: S3C: Use generic clock names for sdhci bus
 clock options
Date: Thu, 3 Nov 2011 02:11:56 +0530
Message-ID: <CAJuYYwSav=zEWLpkSsCLF4RafZHsXimayd2APqBrKe6DiQZKwQ@mail.gmail.com>
References: <1320039876-21148-1-git-send-email-rajeshwari.s@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1320039876-21148-1-git-send-email-rajeshwari.s@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rajeshwari Shinde <rajeshwari.s@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 31 October 2011 11:14, Rajeshwari Shinde <rajeshwari.s@samsung.com> =
wrote:
> This patch modifies the driver to stop depending on the clock names
> being passed from the platform and switch over to bus clock lookup
> using generic clock names.
>
> V6 Changes:
> Changed sprintf to snprintf as suggested by Chris Ball.

The above two lines can be removed from the commit message.

>
> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
> ---
> =A0drivers/mmc/host/sdhci-s3c.c | =A0 =A07 ++-----
> =A01 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3=
c.c
> index 82709b6..488223c 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -435,14 +435,11 @@ static int __devinit sdhci_s3c_probe(struct pla=
tform_device *pdev)

[...]
