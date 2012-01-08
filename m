From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V9 2/2] mmc: host: Adds support for eMMC 4.5 HS200 mode
Date: Sun, 08 Jan 2012 15:37:37 -0500
Message-ID: <m239bqvsku.fsf@bob.laptop.org>
References: <1325823999-21770-1-git-send-email-girish.shivananjappa@linaro.org>
	<1325823999-21770-3-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1325823999-21770-3-git-send-email-girish.shivananjappa@linaro.org>
	(Girish K. S.'s message of "Fri, 6 Jan 2012 09:56:39 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Jan 05 2012, Girish K S wrote:
> @@ -1703,10 +1707,13 @@ static int sdhci_execute_tuning(struct mmc_ho=
st *mmc)
>  	 * Host Controller needs tuning only in case of SDR104 mode
>  	 * and for SDR50 mode when Use Tuning for SDR50 is set in
>  	 * Capabilities register.
> +	 * If the Host Controller supports the HS200 mode then tuning
> +	 * function has to be executed.
>  	 */
>  	if (((ctrl & SDHCI_CTRL_UHS_MASK) =3D=3D SDHCI_CTRL_UHS_SDR104) ||
>  	    (((ctrl & SDHCI_CTRL_UHS_MASK) =3D=3D SDHCI_CTRL_UHS_SDR50) &&
> -	    (host->flags & SDHCI_SDR50_NEEDS_TUNING)))
> +	    (host->flags & SDHCI_SDR50_NEEDS_TUNING)) ||
> +	    (host->flags & SDHCI_HS200_NEEDS_TUNING))
>  		ctrl |=3D SDHCI_CTRL_EXEC_TUNING;
>  	else {
>  		spin_unlock(&host->lock);

Actually, this generates a warning:

/home/cjb/git/mmc/drivers/mmc/host/sdhci.c: In function =E2=80=98sdhci_=
execute_tuning=E2=80=99:
/home/cjb/git/mmc/drivers/mmc/host/sdhci.c:1716:7: warning: suggest par=
entheses around =E2=80=98&&=E2=80=99 within =E2=80=98||=E2=80=99 [-Wpar=
entheses]

=2E. as well as being hard to follow.  Shall we split it up as below in=
stead?

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 64febf2..5627354 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1694,6 +1694,7 @@ static int sdhci_execute_tuning(struct mmc_host *=
mmc, u32 opcode)
 	int tuning_loop_counter =3D MAX_TUNING_LOOP;
 	unsigned long timeout;
 	int err =3D 0;
+	bool requires_tuning_nonuhs;
=20
 	host =3D mmc_priv(mmc);
=20
@@ -1704,16 +1705,19 @@ static int sdhci_execute_tuning(struct mmc_host=
 *mmc, u32 opcode)
 	ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
=20
 	/*
-	 * Host Controller needs tuning only in case of SDR104 mode
-	 * and for SDR50 mode when Use Tuning for SDR50 is set in
+	 * The Host Controller needs tuning only in case of SDR104 mode
+	 * and for SDR50 mode when Use Tuning for SDR50 is set in the
 	 * Capabilities register.
-	 * If the Host Controller supports the HS200 mode then tuning
-	 * function has to be executed.
+	 * If the Host Controller supports the HS200 mode then the
+	 * tuning function has to be executed.
 	 */
-	if ((ctrl & SDHCI_CTRL_UHS_MASK =3D=3D SDHCI_CTRL_UHS_SDR104) ||
-	    ((ctrl & SDHCI_CTRL_UHS_MASK =3D=3D SDHCI_CTRL_UHS_SDR50) &&
-	     host->flags & SDHCI_SDR50_NEEDS_TUNING ||
+	if (((ctrl & SDHCI_CTRL_UHS_MASK) =3D=3D SDHCI_CTRL_UHS_SDR50) &&
+	    (host->flags & SDHCI_SDR50_NEEDS_TUNING ||
 	     host->flags & SDHCI_HS200_NEEDS_TUNING))
+		requires_tuning_nonuhs =3D true;
+
+	if (((ctrl & SDHCI_CTRL_UHS_MASK) =3D=3D SDHCI_CTRL_UHS_SDR104) ||
+	    requires_tuning_nonuhs)
 		ctrl |=3D SDHCI_CTRL_EXEC_TUNING;
 	else {
 		spin_unlock(&host->lock);

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
