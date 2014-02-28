From: Georgi Djakov <gdjakov@mm-sol.com>
Subject: Re: [PATCH v9 3/3] mmc: sdhci-msm: Add platform_execute_tunning implementation
Date: Sat, 01 Mar 2014 00:10:05 +0200
Message-ID: <5311093D.3090409@mm-sol.com>
References: <1393586675-14628-1-git-send-email-gdjakov@mm-sol.com> <1393586675-14628-4-git-send-email-gdjakov@mm-sol.com> <F9D8CFEF-1A3C-4B25-B593-419C56E3A168@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <F9D8CFEF-1A3C-4B25-B593-419C56E3A168@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org, grant.likely@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 28.02.14, 18:51, Kumar Gala wrote:
>=20
> On Feb 28, 2014, at 5:24 AM, Georgi Djakov <gdjakov@mm-sol.com> wrote=
:
>=20
>> This patch adds implementation for platform specific tuning in order=
 to support
>> HS200 bus speed mode on Qualcomm SDHCI controller.
>>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
>> ---
>> drivers/mmc/host/sdhci-msm.c |  424 ++++++++++++++++++++++++++++++++=
+++++++++-
>> 1 file changed, 418 insertions(+), 6 deletions(-)
>=20
> minor nit, in subject (platform_execute_tuning, with one =E2=80=99n=E2=
=80=99).
>=20
> - k

Oh, of course! Thanks!

BR,
Georgi
