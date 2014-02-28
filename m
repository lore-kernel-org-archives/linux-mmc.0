From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v9 3/3] mmc: sdhci-msm: Add platform_execute_tunning implementation
Date: Fri, 28 Feb 2014 10:51:19 -0600
Message-ID: <F9D8CFEF-1A3C-4B25-B593-419C56E3A168@codeaurora.org>
References: <1393586675-14628-1-git-send-email-gdjakov@mm-sol.com> <1393586675-14628-4-git-send-email-gdjakov@mm-sol.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393586675-14628-4-git-send-email-gdjakov@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <gdjakov@mm-sol.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org, grant.likely@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On Feb 28, 2014, at 5:24 AM, Georgi Djakov <gdjakov@mm-sol.com> wrote:

> This patch adds implementation for platform specific tuning in order =
to support
> HS200 bus speed mode on Qualcomm SDHCI controller.
>=20
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
> ---
> drivers/mmc/host/sdhci-msm.c |  424 +++++++++++++++++++++++++++++++++=
++++++++-
> 1 file changed, 418 insertions(+), 6 deletions(-)

minor nit, in subject (platform_execute_tuning, with one =92n=92).

- k

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, host=
ed by The Linux Foundation
